Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:index, :show]
  resources :radars, only: [:index, :new, :create, :show, :destroy] do
    resources :blips, controller: "radars/blips", except: :index
  end
  resources :topics, only: [:index, :show]
end
