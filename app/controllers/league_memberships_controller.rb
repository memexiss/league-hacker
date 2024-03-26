class LeagueMembershipsController < ApplicationController
  def create
    @membership = League::Membership.new(league_membership_params)

    if existing_membership?
      redirect_to leagues_path
    elsif @membership.save
      redirect_to leagues_path
    else
      render :new
    end
  end

  def destroy
    membership = current_user.memberships.find_by(league_id: params[:id])

    if membership&.destroy
      redirect_to leagues_path, notice: 'You have left the league successfully.'
    else
      redirect_to leagues_path, alert: 'Failed to leave the league.'
    end
  end

  private

  def league_membership_params
    params.require(:league_membership).permit(:user_id, :league_id, :membership_type)
  end

  def existing_membership?
    League::Membership.exists?(user_id: current_user.id, league_id: params[:league_membership][:league_id])
  end
end
