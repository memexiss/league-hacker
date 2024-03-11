class LeagueAnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_league

  def new
    @announcement = @league.announcements.build
  end

  def edit
    @announcement = League::Announcement.find(params[:id])
  end

  def create
    @announcement = @league.announcements.build(announcement_params)

    if current_user.memberships.find_by(league: @league, membership_type: 'manager') && @announcement.save
      redirect_to leagues_path
    else
      render :new
    end
  end
  
  def update
    @announcement = League::Announcement.find(params[:id])
  
    if current_user.memberships.find_by(league: @league, membership_type: 'manager') && @announcement.update(announcement_params)
      redirect_to leagues_path
    else
      render :edit
    end
  end  

  private

  def set_league
    @league = League.find(params[:league_id])
  end

  def announcement_params
    params.require(:league_announcement).permit(:title, :body, :published_at, :unpublished_at, :status)
  end
end
