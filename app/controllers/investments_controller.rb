require 'csv'

class InvestmentsController < ApplicationController
  include HTTParty

  before_action :set_investment, only: %i[ show edit update destroy ]

  base_uri 'https://rest.coinapi.io/v1'


  def getCoinSymbol(coin)
    if coin == "Bitcoin"
      return "BTC"
    elsif coin == "Ether"
      return "ETH"
    elsif coin == "Cardano"
      return "ADA"
    else
      return "Other"
    end
  end


  def get_cryptocoin_info()
    table_info = CSV.parse(File.read("app/assets/files/origen.csv"), headers: true)
    cryptocoin_info = []
  
    table_info.each do |row|
      monthly_return = row["Interes_mensual"].to_f / 100.0
      initial_balance = row["balance_ini"].to_f
      annual_balance = calculate_annual_return(monthly_return, initial_balance)
  
      cryptocoin_info << {
        name: row["Moneda"],
        coin_symbol: getCoinSymbol(row["Moneda"]),
        monthly_return: row["Interes_mensual"],
        initial_balance: initial_balance,
        annual_balance: annual_balance.round(2),
        price_usd: get_coin_price(row["Moneda"])
      }
    end

    cryptocoin_info
  end


  def get_coin_price(coin)
    access_token = Rails.application.credentials.dig(:coin_api_access_token)
    headers = {
      'X-CoinAPI-Key' => access_token
    }
    coin_symbol = getCoinSymbol(coin)
    response = self.class.get("/exchangerate/#{coin_symbol}/USD", headers: headers)
    
    if response.success?
      price_data = JSON.parse(response.body)
      return price_data["rate"]
    else
      return nil
    end
  end


  def calculate_annual_return(monthly_return, initial_balance)
    annual_return = initial_balance
    12.times do
      annual_return *= (1 + monthly_return)
    end
    annual_return
  end


  def csv_export
    @cryptocoin_info = get_cryptocoin_info
    data = @cryptocoin_info.map { |info| [info["name"], info["initial_balance"], info["monthly_return"], info["annual_balance"], info["price_usd"] ] }
  
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["Moneda", "Balance Inicial", "Retorno Mensual", "Balance Anual Proyectado", "Balance Anual Proyectado en USD"]
      data.each { |row| csv << row }
    end

    respond_to do |format|
      format.csv { send_data csv_data, filename: "investments.csv" }
    end
  
  end
  

  def json_export
    @cryptocoin_info = get_cryptocoin_info
    json_data = @cryptocoin_info.to_json

    respond_to do |format|
      format.json { send_data json_data, filename: "investments.json" }
    end
  end
  

  # GET /investments or /investments.json
  def index
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
