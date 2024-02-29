class Admin::LeagueEventRoundScorecardsController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin
  before_action :set_league_event_round_and_scorecard
  
  def index
    @round_number = params[:round_number]
  end

  def edit
    @scorecard = League::Event::Round::Scorecard.find(params[:id])
    @users = User.all
  end

  def update
    @scorecards = League::Event::Round::Scorecard.find(params[:id])
  
    if @scorecards.update(scorecard_params)
      redirect_to admin_league_event_round_scorecards_path(@league, @event)
    else
      render :edit
    end
  end  

  def new
    @round_number = @event.rounds.count + 1
    @round = @event.rounds.find(params[:round_id])
    @scorecard = League::Event::Round::Scorecard.new
    @users = User.all
  end

  def create
    @scorecard = League::Event::Round::Scorecard.new(scorecard_params)
    @scorecard.round = @round
    if @scorecard.save
      redirect_to admin_league_event_round_scorecards_path(@league, @event, @round)
    else
      redirect_to admin_leagues_path
    end
  end
  
	def destroy
    @scorecard = League::Event::Round::Scorecard.find(params[:id])
		@scorecard.destroy

    redirect_to admin_leagues_path
  end

  private

  def scorecard_params
    params.require(:league_event_round_scorecard).permit(:round_id, :user_id, :score_gross,
      :score_net, :score_best_of_holes, :score_chicago, :score_stableford, :computed_score_method)
  end
  def set_league_event_round_and_scorecard
    @league = League.find(params[:league_id])
    @event = @league.events.find(params[:event_id])
    @round = @event.rounds.find(params[:round_id])
  end
end
