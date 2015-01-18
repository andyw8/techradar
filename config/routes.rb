Rails.application.routes.draw do
  root to: "home#show"
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:index, :show]
  resources :radars, except: :show do
    resources :blips, controller: "radars/blips", except: :index
  end
  get "/radars/:id(/:quadrant)", controller: "radars", action: "show", as: "radar_quadrant"
  resources :topics, only: [:index, :show, :new, :create]
end
