class Admin::DashboardController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin

  def index
  end

end
