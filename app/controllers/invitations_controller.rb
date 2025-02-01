class InvitationsController < ApplicationController
  before_action :set_invitation
  before_action :validate_inviatation

  # GET /invitation/confirm/:token
  def confirm
    if @invitation.accepted?
      redirect_to rodauth(:hacker).login_path,
        alert: "The invitation has already been accepted."
    else
      cookies.encrypted[:invite_token] = @invitation.token
      @team = @invitation.team
    end
  end

  # POST /invitation/confirm/:token/decline
  def decline
    @invitation.declined!
    cookies.delete(:invite_token)

    redirect_to confirm_invitation_path,
      alert: "You have declined the invite. " \
      "Please contact the person who invited you if this was a mistake."
  end

  # POST /invitation/confirm/:token/accept
  def accept
    if @invitation.declined?
      return redirect_to confirm_invitation_path,
                         alert: "This invite link has been declined, " \
                         "contact the person who invited you."
    end

    redirect_to rodauth(:hacker).create_account_path,
      notice: "Complete your account to your continue."
  end

  private

  def set_invitation
    @invitation = ::Hackathon::Invitation.includes(team: [:hacker])
                                         .find_by(token: params[:token])
  end

  # Ensure the invitation is one we are aware of, anything else is forged.
  def validate_inviatation
    redirect_to root_path, alert: "Invalid invitation link." unless @invitation
  end
end
