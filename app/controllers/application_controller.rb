


class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up){ |u| u.permit(:username, :email, :password, :password_confirmation ,:role)}

      devise_parameter_sanitizer.permit(:account_update){ |u| u.permit(:username, :email, :password, :password_confirmation, :current_password)}
    end
  private
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action"
      redirect to root_path
    end
end
