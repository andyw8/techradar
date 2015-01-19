class UsernameConstraint
  def self.matches?(request)
    User.find_by(username: request.params[:username]).present?
  end
end

Rails.application.routes.draw do
  root to: "home#show"
  devise_for :users, controllers: { registrations: "registrations" }
  get "/:username", constraints: UsernameConstraint, controller: "users", action: "show"
  resources :users, only: [:index, :show]
  resources :radars, except: :show do
    resources :blips, controller: "radars/blips", except: :index
  end
  get "/radars/:id(/:quadrant)", controller: "radars", action: "show", as: "radar_quadrant"
  resources :topics, only: [:index, :show, :new, :create]
  get "/about", controller: "pages", action: "about"
end
