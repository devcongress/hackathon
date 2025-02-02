class InvitationsController < ApplicationController
  before_action :set_invitation
  before_action :validate_invitation

  # GET /invitation/confirm/:token
  def confirm
    cookies.encrypted[:invite_token] = @invitation.token
    @team = @invitation.team
  end

  # POST /invitation/confirm/:token/decline
  def decline
    @invitation.declined!
    cookies.delete(:invite_token)

    redirect_to root_path,
      alert: "You have declined the invite. Please contact the person who invited you if this was a mistake."
  end

  # POST /invitation/confirm/:token/accept
  def accept
    redirect_to rodauth(:hacker).create_account_path,
      notice: "Complete your account to your continue."
  end

  private

  def set_invitation
    invitation_id = Rails.application.message_verifier(:invite_token)
      .verify(params[:token], purpose: :invitation)

    @invitation = Hackathon::Invitation.find(invitation_id)
  end

  # Ensure the invitation is one we are aware of, anything else is forged.
  def validate_invitation
    return if @invitation&.invited?

    render :invalid
    false
  end
end
