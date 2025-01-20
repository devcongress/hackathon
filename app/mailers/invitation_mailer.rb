class InvitationMailer < ApplicationMailer
  def send_invite
    @invited_hacker = params[:hacker]
    @team = @invited_hacker.team
    @owner = @team.owner
    @url = confirm_invitation_url(token: @invited_hacker.token)

    mail to: @invited_hacker.email,
         subject: "Join '#{@team.name}' for the Hackathon!"
  end
end
