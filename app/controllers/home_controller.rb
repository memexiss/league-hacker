class HomeController < ApplicationController
  def index
    if user_signed_in?
      @memberships = current_user.memberships.includes(league: { events: { rounds: :scorecards } })
    else
      
    end
  end
end