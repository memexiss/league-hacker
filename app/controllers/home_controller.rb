class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.memberships.any?
      @memberships = current_user.memberships.includes(league: { events: { rounds: :scorecards } })
      # a = current_user.memberships.first.league.events.first.rounds.first.scorecards.create user: current_user
      # raise 'it '
      @scorecards =  current_user.memberships.first.league.events.first.rounds.first.scorecards.order(score_gross: :desc)
    else
      # redirect_to new_user_session_path
    end
  end
end
