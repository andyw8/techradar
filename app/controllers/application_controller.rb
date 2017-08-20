class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource)
    # new users will already have one sample topic
    progress = Progress.new(current_user)
    if progress.already_has_topics?
      radars_path
    else
      new_bulk_topic_path
    end
  end

  def authenticate_admin
    return if current_user && current_user.admin?
    redirect_to root_url, notice: "Access denied, admin only"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
