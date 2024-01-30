require 'rails_helper'

RSpec.describe "cryptocoins/edit", type: :view do
  let(:cryptocoin) {
    Cryptocoin.create!(
      name: "MyString",
      monthly_return: 1.5
    )
  }

  before(:each) do
    assign(:cryptocoin, cryptocoin)
  end

  it "renders the edit cryptocoin form" do
    render

    assert_select "form[action=?][method=?]", cryptocoin_path(cryptocoin), "post" do

      assert_select "input[name=?]", "cryptocoin[name]"

      assert_select "input[name=?]", "cryptocoin[monthly_return]"
    end
  end
end
