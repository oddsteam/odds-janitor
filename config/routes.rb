Rails.application.routes.draw do
  resources :roomdetails

  resources :reserves do
    collection do
      patch "update_selected_date"
    end
  end

  get "pages/home"

  get "/callback", to: "sessions#callback"
  get "logout", to: "sessions#logout"
  get "/new", to: "reserves#new"
  root "reserves#index"
end