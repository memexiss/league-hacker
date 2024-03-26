class Admin::UsersController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin
  before_action :authorize_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  
    if @user.update(user_edit_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  
    if @user.save
      redirect_to admin_users_path
    else
      redirect_to admin_users_path
    end
  end
  
	def destroy
    @user = User.find(params[:id])
		@user.destroy

    redirect_to admin_users_path
  end

  private

  def authorize_admin
    return unless !current_user.admin?
    redirect_to admin_root_path, alert: 'Admins only!'
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation, :phone, :ghin_handicap, :ghin_number)
  end
  def user_edit_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :role, :ghin_handicap, :ghin_number)
  end
end
