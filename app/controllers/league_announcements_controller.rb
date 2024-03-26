class LeagueAnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_league
  before_action :authorize_manager, only: [:new, :create, :edit, :update]

  def index
    @announcements = @league.announcements
    @scorecards =  current_user.memberships.first.league.events.first.rounds.first.scorecards.order(score_gross: :desc)
  end

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

  def mark_as_read
    announcement = League::Announcement.find(params[:id])
    unless current_user.announcement_reads.exists?(league_announcement_id: announcement.id)
      current_user.announcement_reads.create(league_announcement_id: announcement.id, read_at: Time.now)
    end
    redirect_to league_announcements_path, notice: 'Announcement marked as read.'
  end
  
  private

  def set_league
    @league = League.find(params[:league_id])
  end

  def authorize_manager
    unless current_user.memberships.find_by(league: @league, membership_type: 'manager')
      flash[:alert] = "You don't have permission to perform this action."
      redirect_to leagues_path
    end
  end

  def announcement_params
    params.require(:league_announcement).permit(:title, :body, :published_at, :unpublished_at, :status)
  end
end
