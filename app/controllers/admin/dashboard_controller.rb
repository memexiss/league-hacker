class Admin::DashboardController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin

  def index
    @users = User.all
    @courses = GolfCourse.all
    @leagues = League.all
  end

end
