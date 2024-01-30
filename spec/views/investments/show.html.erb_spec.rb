require 'rails_helper'

RSpec.describe "investments/show", type: :view do
  before(:each) do
    assign(:investment, Investment.create!(
      price: 2.5,
      cryptocoins: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
  end
end
