class AdminsController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin

  def show
    @users = User.all
    @courses = Course.all
  end
  def index
    @users = User.all
    @courses = Course.all
  end
end
