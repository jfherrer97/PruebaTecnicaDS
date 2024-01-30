require 'rails_helper'

RSpec.describe InvestmentsController, type: :controller do
  describe "GET #update_annual_balance_usd_value" do
    it "should get the value of update_annual_balance_usd_value" do
      # Receive update_annual_balance_usd_value response
      allow(controller).to receive(:update_annual_balance_usd_value)
      get :update_annual_balance_usd_value, format: :json
      expect(response).to have_http_status(:success)
    end
  end
end