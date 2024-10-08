Rails.application.routes.draw do
  get "hello_world", to: "hello_world#index"
  resources :properties do
    resources :expenses
    resources :incomes
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
