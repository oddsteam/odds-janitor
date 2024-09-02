Rails.application.routes.draw do
  get 'pages/home'
  
  get "up" => "rails/health#show", as: :rails_health_check
   get 'pages/home', to: 'pages#home'

end
