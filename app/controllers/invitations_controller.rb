class InvitationsController < ApplicationController
  before_action :set_invitation

  def confirm
    if @invitation
      if @invitation.accepted?
        redirect_to rodauth(:hacker).login_path,
          alert: "The invitation has already been accepted."
      else
        cookies.encrypted[:invite_token] = @invitation.token

        redirect_to rodauth(:hacker).create_account_path,
          notice: "Valid invitation link. Complete your profile to join " \
          "the team: #{@invitation.team.name}."
      end
    else
      redirect_to root_path,
        alert: "Invalid invitation link."
    end
  end

  private

  def set_invitation
    @invitation = ::Hackathon::Invitation.includes(:team)
      .find_by(token: params[:token])
  end
end
