require 'rails_helper'

RSpec.describe "investments/edit", type: :view do
  let(:investment) {
    Investment.create!(
      price: 1.5,
      cryptocoins: nil
    )
  }

  before(:each) do
    assign(:investment, investment)
  end

  it "renders the edit investment form" do
    render

    assert_select "form[action=?][method=?]", investment_path(investment), "post" do

      assert_select "input[name=?]", "investment[price]"

      assert_select "input[name=?]", "investment[cryptocoins_id]"
    end
  end
end
