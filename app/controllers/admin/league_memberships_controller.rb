class Admin::LeagueMembershipsController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin
  
  def edit
    @membership = League::Membership.find(params[:id])
    @leagues = League.all
    @users = User.all
  end

  def update
    @memberships = League::Membership.find(params[:id])
  
    if @memberships.update(memberships_params)
      redirect_to admin_leagues_path
    else
      render :edit
    end
  end  

  def new
    @membership = League::Membership.new
    @leagues = League.all
    @users = User.all
  end

  def create
    @membership = League::Membership.new(memberships_params)
  
    if @membership.save
      redirect_to admin_leagues_path
    else
      redirect_to admin_leagues_path
    end
  end
  
	def destroy
    @membership = League::Membership.find(params[:id])
		@membership.destroy

    redirect_to admin_leagues_path
  end

  private

  def memberships_params
    params.require(:league_membership).permit(:user_id, :league_id, :membership_type)
  end
end
