class Admin::LeagueEventRoundsController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin
  before_action :set_league_event_and_round
  
  def index

  end

  def edit
    @round = League::Event::Round.find(params[:id])
    @leagues = League.all
    @users = User.all
  end

  def update
    @rounds = League::Event::Round.find(params[:id])
  
    if @rounds.update(rounds_params)
      redirect_to admin_league_event_rounds_path(@league, @event)
    else
      render :edit
    end
  end  

  def new
    @round_number = @event.rounds.count + 1
    @round = League::Event::Round.new
    @leagues = League.all
    @users = User.all
  end

  def create
    @round = League::Event::Round.new(rounds_params)
    @round.event = @event
    if @round.save
      redirect_to admin_league_event_rounds_path(@league, @event)
    else
      redirect_to admin_leagues_path
    end
  end
  
	def destroy
    @round = League::Event::Round.find(params[:id])
		@round.destroy

    redirect_to admin_leagues_path
  end

  private

  def rounds_params
    params.require(:league_event_round).permit(:position, :scoring_format, :playing_format,
      :start_date, :end_date, :starting_hole, :number_of_holes, :event_id)
  end
  def set_league_event_and_round
    @league = League.find(params[:league_id])
    @event = @league.events.find(params[:event_id])
  end
end
