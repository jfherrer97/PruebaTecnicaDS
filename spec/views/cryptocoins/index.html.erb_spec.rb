require 'rails_helper'

RSpec.describe "cryptocoins/index", type: :view do
  before(:each) do
    assign(:cryptocoins, [
      Cryptocoin.create!(
        name: "Name",
        monthly_return: 2.5
      ),
      Cryptocoin.create!(
        name: "Name",
        monthly_return: 2.5
      )
    ])
  end

  it "renders a list of cryptocoins" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.5.to_s), count: 2
  end
end
