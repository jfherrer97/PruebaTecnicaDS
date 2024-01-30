require 'rails_helper'

RSpec.describe "cryptocoins/show", type: :view do
  before(:each) do
    assign(:cryptocoin, Cryptocoin.create!(
      name: "Name",
      monthly_return: 2.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
  end
end
