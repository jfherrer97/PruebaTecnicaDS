require 'rails_helper'

RSpec.describe "cryptocoins/new", type: :view do
  before(:each) do
    assign(:cryptocoin, Cryptocoin.new(
      name: "MyString",
      monthly_return: 1.5
    ))
  end

  it "renders new cryptocoin form" do
    render

    assert_select "form[action=?][method=?]", cryptocoins_path, "post" do

      assert_select "input[name=?]", "cryptocoin[name]"

      assert_select "input[name=?]", "cryptocoin[monthly_return]"
    end
  end
end
