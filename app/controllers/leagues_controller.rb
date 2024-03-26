class LeaguesController < ApplicationController

  def index
    @leagues = League.all
  end

  def edit
    @league = League.find(params[:id])
  end

  def show 
    if user_signed_in? && current_user.memberships.any?
      @memberships = current_user.memberships.includes(league: { events: { rounds: :scorecards } })
      @scorecards =  current_user.memberships.first.league.events.first.rounds.first.scorecards.order(score_gross: :desc)
    else
      
    end
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
    @leagues = League.all
    @league = League.new
  end

  def create
    @league = League.new(league_params)
  
    if @league.save
      current_user.memberships.create(league: @league, membership_type: 'manager')

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
      :name, :payment_link, :league_type, :logo
    )
  end
end
