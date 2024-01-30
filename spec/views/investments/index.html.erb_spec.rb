require 'rails_helper'

RSpec.feature "Investments View", type: :feature do
  scenario "User should see investment information and updates automatically" do
    # Go to investments index page
    visit investments_path

    # Show investment information
    expect(page).to have_content("Calculadora de Inversiones")
    expect(page).to have_selector("table tbody tr", count: 3) # Verificar que hay 3 filas en la tabla

    # Show annual_balance_usd value
    expect(page).to have_selector("#annual_balance_usd_cell")
  end

  scenario "User should export investment information to CSV" do
    # Go to investments index page
    visit investments_path

    # Click CSV button
    click_button "Exportar a CSV"

    # CSV file download
    expect(page.response_headers['Content-Type']).to eq('text/csv')
    expect(page.response_headers['Content-Disposition']).to include('attachment')
  end
end
