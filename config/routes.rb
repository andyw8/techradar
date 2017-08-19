require 'sidekiq/web'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "home#show"
  devise_for :users, controllers: { registrations: "registrations" }

  mount Sidekiq::Web => '/sidekiq'

  get "/:username", constraints: UsernameConstraint, controller: "users", action: "show"
  resources :users, only: %i[index show]

  resources :radars do
    resources :blips, controller: "radars/blips", except: :index
  end

  get "/radars/:id/:quadrant", controller: "radars/quadrants", action: "show", as: "radar_quadrant"
  resources :topics, only: %i[show new create]
  resources :bulk_topics, only: %i[new create]
  get "/about", controller: "pages", action: "about"

  namespace "api" do
    namespace "v1" do
      resources :radars, only: :show
    end
  end
end
