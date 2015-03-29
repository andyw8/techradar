class RegistrationsController < Devise::RegistrationsController
  before_action :update_sanitized_params, if: :devise_controller?
  PARAMS = %i(name username email password password_confirmation)

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) do |params|
      params.permit(PARAMS)
    end

    devise_parameter_sanitizer.for(:account_update) do |params|
      # :nocov:
      params.permit(PARAMS + :current_password)
      # :nocov:
    end
  end

  def build_resource(args)
    super.subscribe(Starter.new)
  end
end
