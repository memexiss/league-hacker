class ScorecardEntriesController < ApplicationController
  before_action :find_scorecard

  def new
    @entry = League::Event::Round::Scorecard::Entry.new
  end

  def create
    @scorecard = League::Event::Round::Scorecard.find_or_create_by(round: @round)
    @entry = @scorecard.entries.new(entry_params)
  
    if @entry.save
      @scorecard.update(
        score_gross: @entry.score,
        score_net: @entry.score,
        score_best_of_holes: @entry.score,
        score_chicago: @entry.score,
        score_stableford: @entry.score,
        user_id: current_user.id
      )
      redirect_to root_path
    else
      render :new
    end
  end
  

  private

  def find_scorecard
    round_id = params[:round_id] || params.dig(:league_event_round_scorecard_entry, :round_id)
    @round = League::Event::Round.find(round_id)
    @scorecard = @round.scorecards.first_or_create
  end  

  def entry_params
    params.require(:league_event_round_scorecard_entry).permit(:hole_id, :score).merge(scorecard_id: @scorecard.id)
  end
end
