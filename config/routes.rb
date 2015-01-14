Rails.application.routes.draw do
  root to: "home#show"
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:index, :show]
  resources :radars do
    resources :blips, controller: "radars/blips", except: :index
  end
  resources :topics, only: [:index, :show, :new, :create]
end
