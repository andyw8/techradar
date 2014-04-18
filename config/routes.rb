Techradar::Application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users
  resources :radars, only: [:index, :new, :create, :show, :destroy]
end
