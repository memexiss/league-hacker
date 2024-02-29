class Admin::LeaguesController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin

  def index
    @leagues = League.all
    @memberships = League::Membership.all
  end

  def edit
    @league = League.includes(:events).find(params[:id])
  end

  def show 
    @league = League.find(params[:id])
    @event = League.find(params[:id]).events.first
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
    @leagues = League.all
    @league = League.new
    @event = @league.events.build
    @round = @event.rounds.build
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
    params.require(:league).permit(
      :name, :payment_link, :league_type, :logo,
      events_attributes: [
        :id, :start_date, :end_date, :event_type, :entry_fee, :number_of_rounds,
        :per_round_fee, :average_holes_per_round, :status,
        :league_id,
      ]
    )
  end
end
