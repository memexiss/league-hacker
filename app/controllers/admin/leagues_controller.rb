class Admin::LeaguesController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin

  def index
    @leagues = League.all
    @memberships = League::Membership.all
  end

  def edit
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])
  
    if @league.update(league_params)
      redirect_to admin_leagues_path
    else
      render :edit
    end
  end  

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
  
    if @league.save
      redirect_to admin_leagues_path
    else
      redirect_to admin_leagues_path
    end
  end
  
	def destroy
    @league = League.find(params[:id])
		@league.destroy

    redirect_to admin_leagues_path
  end

  private

  def league_params
    params.require(:league).permit(:name, :payment_link, :league_type)
  end
end
