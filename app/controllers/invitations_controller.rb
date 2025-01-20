class InvitationsController < ApplicationController
  def confirm
    @invited_hacker = ::Hackathon::Invitation.includes(:team)
                                             .find_by(token: params[:token])

    if @invited_hacker
      if @invited_hacker.accepted?
        redirect_to rodauth(:hacker).login_path,
                    alert: "The invitation has already been accepted."
      else
        cookies.encrypted[:invite_token] = @invited_hacker.token

        redirect_to rodauth(:hacker).create_account_path,
          notice: "Valid invitation link. Complete your profile to join " \
          "the team: #{@invited_hacker.team.name}."
      end
    else
      redirect_to root_path,
                  alert: "Invalid invitation link."
    end
  end
end
