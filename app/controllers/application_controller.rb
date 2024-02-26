class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def verify_sign_in
    if !user_signed_in?
      redirect_to root_path
    end
  end
  def verify_admin
    if !current_user.admin?
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
  end
  
end
