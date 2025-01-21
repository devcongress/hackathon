class HackerDashboardPortal::ProfilesController < ::ProfilesController
  include HackerDashboardPortal::Concerns::Controller

  authorize :invitation, through: :current_invitation
  skip_before_action :ensure_profile_complete, only: [:new, :create]

  private

  def current_invite_token
    cookies.encrypted[:invite_token]
  end

  def current_invitation
    if current_invite_token
      @current_invitation ||= Hackathon::Invitation.includes(:team).find_by(token: current_invite_token)
    end
  end

  # def handle_successful_save(invite_token)
  #   if invited_hacker?
  #     @invited_hacker.update!(accepted: true, profile: @profile)
  #     cookies.delete(:invite_token)

  #     InvitationMailer.with(hacker: @profile).confirm_invite.deliver_later

  #     if @team.hackers.count >= 3
  #       TeamMailer.with(team: @team).validated.deliver_later
  #     end
  #   end

  #   redirect_to(@profile, notice: "Profile was successfully created.")
  # end

  # def redirect_to_new_profile_with_alert(message)
  #   redirect_to resource_url_for(::Profile, action: :new), alert: message
  # end

  # def invited_hacker?
  #   @invited_hacker
  # end
end
