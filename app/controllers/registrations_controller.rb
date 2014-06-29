class RegistrationsController < Devise::RegistrationsController
  before_action :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) do |params|
      params.permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
    end

    devise_parameter_sanitizer.for(:account_update) do |params|
      params.permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :current_password
      )
    end
  end

  def build_resource(args)
    super.subscribe(Starter.new)
  end
end
