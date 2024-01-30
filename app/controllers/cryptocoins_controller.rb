class CryptocoinsController < ApplicationController
  before_action :set_cryptocoin, only: %i[ show edit update destroy ]

  # GET /cryptocoins or /cryptocoins.json
  def index
    @cryptocoins = Cryptocoin.all
  end

  # GET /cryptocoins/1 or /cryptocoins/1.json
  def show
  end

  # GET /cryptocoins/new
  def new
    @cryptocoin = Cryptocoin.new
  end

  # GET /cryptocoins/1/edit
  def edit
  end

  # POST /cryptocoins or /cryptocoins.json
  def create
    @cryptocoin = Cryptocoin.new(cryptocoin_params)

    respond_to do |format|
      if @cryptocoin.save
        format.html { redirect_to cryptocoin_url(@cryptocoin), notice: "Cryptocoin was successfully created." }
        format.json { render :show, status: :created, location: @cryptocoin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cryptocoin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cryptocoins/1 or /cryptocoins/1.json
  def update
    respond_to do |format|
      if @cryptocoin.update(cryptocoin_params)
        format.html { redirect_to cryptocoin_url(@cryptocoin), notice: "Cryptocoin was successfully updated." }
        format.json { render :show, status: :ok, location: @cryptocoin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cryptocoin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cryptocoins/1 or /cryptocoins/1.json
  def destroy
    @cryptocoin.destroy!

    respond_to do |format|
      format.html { redirect_to cryptocoins_url, notice: "Cryptocoin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cryptocoin
      @cryptocoin = Cryptocoin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cryptocoin_params
      params.require(:cryptocoin).permit(:name, :monthly_return)
    end
end
