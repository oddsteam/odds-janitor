Rails.application.routes.draw do
  resources :roomdetails, only: [:index]

  resources :reserves do
    collection do
      patch 'update_selected_date'
    end
  end

  resources :reserves
  get 'pages/home'
  
  get "up" => "rails/health#show", as: :rails_health_check
  get "/lobby", to: "sessions#lobby"
  get "/callback", to: "sessions#callback"
  get "logout", to: "sessions#logout"

  root "reserves#index"
end
