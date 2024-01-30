require 'rails_helper'

RSpec.describe "investments/new", type: :view do
  before(:each) do
    assign(:investment, Investment.new(
      price: 1.5,
      cryptocoins: nil
    ))
  end

  it "renders new investment form" do
    render

    assert_select "form[action=?][method=?]", investments_path, "post" do

      assert_select "input[name=?]", "investment[price]"

      assert_select "input[name=?]", "investment[cryptocoins_id]"
    end
  end
end
