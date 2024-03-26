class ScorecardsController < ApplicationController
  before_action :find_round, :verify_membership

  def new
    @scorecard = League::Event::Round::Scorecard.new
    @scorecard.entries.build
    @total_yards = 0
    @total_par = 0
    @total_score = 0
    GolfCourse::Hole.all.each do |hole|
      @total_yards += hole.tees.first.yards
      @total_par += hole.par
      @total_score += @scorecard.entries.find_by(hole_id: hole.id).score if @scorecard.entries.find_by(hole_id: hole.id)
    end
  end

  def create
    if @round.scorecards.exists?(user_id: current_user.id)
      redirect_to root_path, alert: 'You have already posted a score for this round.'
      return
    end
  
    @scorecard = @round.scorecards.build(scorecard_params)
    @scorecard.user_id = current_user.id
  
    if @scorecard.save
      total_score = @scorecard.entries.sum(:score)
      @scorecard.update(
        score_gross: total_score,
        score_net: total_score,
        score_chicago: total_score,
        score_best_of_holes: total_score,
        score_stableford: total_score
      )
  
      redirect_to root_path, notice: 'Scorecard created successfully.'
    else
      render :new
    end
  end
  

  private

  def find_round
    @round = League::Event::Round.find(params[:round_id])
  end  

  def scorecard_params
    params.require(:league_event_round_scorecard).permit(entries_attributes: [:hole_id, :score])
  end

  def verify_membership
    league_id = @round.event.league_id
    unless current_user.memberships.exists?(league_id: league_id)
      redirect_to root_path, alert: 'You are not a member of the league for this event.'
    end
  end
end
