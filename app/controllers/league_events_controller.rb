class LeagueEventsController < ApplicationController
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
    @event.teams.build if @event.league.league_type == "team"
  end

  def create
    @event = League::Event.new(event_params)
    @event.league = @league
  
    if @event.save
      create_team_users_for_event(@event)
      redirect_to admin_league_events_path
    else
      render :new
    end
  end
  
	def destroy
    @event = League.find(params[:id])
		@event.destroy

    redirect_to admin_league_events_path
  end

  private
  def create_team_users_for_event(event)
    if event.league.league_type == "team" && event.teams.present?
      event.teams.each do |team|
        League::Event::Team::TeamUser.create(team: team, user: current_user)
      end
    end
  end
  def event_params
    params.require(:league_event).permit(
      :start_date, :end_date, :event_type, :entry_fee, :number_of_rounds,
      :per_round_fee, :average_holes_per_round, :status,
      :event_id, teams_attributes: [:name, :team_users])
  end
  def set_league
    @league = League.find(params[:league_id])
  end
end