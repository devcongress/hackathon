class InvitationMailer < ApplicationMailer
  before_action :set_details

  def send_invite
    @url = confirm_invitation_url(token: @invitation.token)
    mail to: @invitation.email,
      subject: "🚀 You're Invited: Join #{@team.name} at Hack by Achieve!"
  end

  def confirm_invite
    mail to: email_address_with_name(@owner.email, @invitation.name),
      subject: "Registration Complete!"
  end

  private

  def set_details
    @invitation = params[:invitation]
    @team = @invitation.team
    @owner = @team.hacker
  end
end
