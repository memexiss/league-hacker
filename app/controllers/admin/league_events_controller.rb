class Admin::LeagueEventsController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin
  before_action :set_league


  def index
  end

  def edit
    @event = League::Event.find(params[:id])
  end

  def show 
    @event = League::Event.find(params[:id])
  end

  def update
    @event = League::Event.find(params[:id])
  
    if @event.update(event_params)
      redirect_to admin_league_events_path
    else
      render :edit
    end
  end  

  def new
    @event = @league.events.build
  end

  def create
    @event = League::Event.new(event_params)
    @event.league = @league
    if @event.save
      redirect_to admin_league_events_path
    else
      redirect_to admin_league_events_path
    end
  end
  
	def destroy
    @event = League.find(params[:id])
		@event.destroy

    redirect_to admin_league_events_path
  end

  private

  def event_params
    params.require(:league_event).permit(
      :start_date, :end_date, :event_type, :entry_fee, :number_of_rounds,
      :per_round_fee, :average_holes_per_round, :status,
      :event_id,    )
  end
  def set_league
    @league = League.find(params[:league_id])
  end
end