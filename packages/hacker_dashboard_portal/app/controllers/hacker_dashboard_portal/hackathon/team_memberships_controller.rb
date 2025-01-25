class HackerDashboardPortal::Hackathon::TeamMembershipsController < ::Hackathon::TeamMembershipsController
  include HackerDashboardPortal::Concerns::Controller

  authorize :invitation, through: :current_invitation

  skip_before_action :ensure_joined_team, only: [ :new, :create ]
  after_action :handle_success, only: [ :create ]

  def present_scoped_entity? = true

  def set_page_title(title)
    if title == "Create #{resource_class.model_name.human.titleize}"
      super("Join #{current_parent.name}")
    else
      super
    end
  end

  private

    def handle_success
      @invitation.accepted!

      connect_profile_to_invitation
      send_confirmation_email
      delete_invite_cookie
    end

    def current_invitation
      return unless cookies.encrypted[:invite_token]

      @invitation ||= ::Hackathon::Invitation.find_by(
        token: cookies.encrypted[:invite_token],
      )
    end

    def delete_invite_cookie
      cookies.delete(:invite_token)
    end

    def connect_profile_to_invitation
      @invitation.update(profile: current_user.profile)
    end

    def send_confirmation_email
      InvitationMailer.with(hacker: current_user.profile)
                      .confirm_invite.deliver_later
    end
end
