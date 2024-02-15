class ApplicationController < ActionController::Base
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

end
