require 'csv'

class InvestmentsController < ApplicationController
  include HTTParty

  before_action :set_investment, only: %i[ show edit update destroy ]

  base_uri "https://rest.coinapi.io/v1/"

  def get_cryptocoin_info
    table_info = CSV.parse(File.read("app/assets/files/origen.csv"), headers: true)
    cryptocoin_info = []
    for i in 0..table_info.length - 1
      cryptocoin_info << { name: table_info[i]["Moneda"], monthly_return: table_info[i]["Interes_mensual"], initial_balance: table_info[i]["balance_ini"], annual_balance: 5}
    end
    cryptocoin_info
  end

  def get_coin_api_information
    access_token = Rails.application.credentials.dig(:coin_api_access_token)
    headers = {
    'X-CoinAPI-Key' => access_token
    }
    response = self.class.get('/assets', headers: headers)
    
    if response.success?
        render json: response.parsed_response
    else
        render json: { error: 'Error when getting info from CoinAPI' }, status: :unprocessable_entity
    end
  end

  def calculate_annual_return(monthly_return, initial_balance)
    annual_return = initial_balance
    12.times do
      annual_return *= (1 + monthly_return)
    end
    annual_return
  end

  # GET /investments or /investments.json
  def index
    # @investments = Investment.all
    @cryptocoin_info = get_cryptocoin_info
  end

  # GET /investments/1 or /investments/1.json
  def show
  end

  # GET /investments/new
  def new
    @investment = Investment.new
  end

  # GET /investments/1/edit
  def edit
  end

  # POST /investments or /investments.json
  def create
    @investment = Investment.new(investment_params)

    respond_to do |format|
      if @investment.save
        format.html { redirect_to investment_url(@investment), notice: "Investment was successfully created." }
        format.json { render :show, status: :created, location: @investment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investments/1 or /investments/1.json
  def update
    respond_to do |format|
      if @investment.update(investment_params)
        format.html { redirect_to investment_url(@investment), notice: "Investment was successfully updated." }
        format.json { render :show, status: :ok, location: @investment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investments/1 or /investments/1.json
  def destroy
    @investment.destroy!

    respond_to do |format|
      format.html { redirect_to investments_url, notice: "Investment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investment
      @investment = Investment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def investment_params
      params.require(:investment).permit(:price, :cryptocoins_id)
    end
end
