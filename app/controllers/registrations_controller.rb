class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :username])
  end

  def build_resource(args)
    super.subscribe(Starter.new)
  end
end
