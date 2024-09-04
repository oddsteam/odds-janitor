Rails.application.routes.draw do
  resources :roomdetails, only: [:index]

  resources :reserves
  get 'pages/home'
  
  get "up" => "rails/health#show", as: :rails_health_check
  root "pages#home"
  get "/lobby", to: "sessions#lobby"
  get "/callback", to: "sessions#callback"
  get "logout", to: "sessions#logout"
end
