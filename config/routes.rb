Rails.application.routes.draw do
  resources :investments do
    get 'csv_export', on: :collection
    get 'json_export', on: :collection
  end
  resources :cryptocoins
  get '/update_annual_balance_usd_value', to: 'investments#update_annual_balance_usd_value'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "investments#index"
end
