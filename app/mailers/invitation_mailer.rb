class InvitationMailer < ApplicationMailer
  before_action :set_details

  def send_invite
    @url = confirm_invitation_url(token: @invited_hacker.token)

    mail to: @invited_hacker.email,
      subject: "Join '#{@team.name}' for the Hackathon!"
  rescue => e
    Rails.logger.error("Failed to send invitation email: #{e.message}")
    @invitation.failed!
  else
    @invitation.sent!
  end

  def confirm_invite
    mail to: email_address_with_name(@owner.email, @invited_hacker.name),
      subject: "Registration Complete!"
  end

  private

  def set_details
    @invited_hacker = params[:hacker]
    @team = @invited_hacker.team
    @owner = @team.hacker

    # An alias for invited hacker
    @invitation = @invited_hacker
  end
end
