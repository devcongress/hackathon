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

      delete_invite_cookie
      check_team_validity
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

    def check_team_validity
      if current_user.reload.team.validated?
        TeamMailer.with(team: current_user.team).validated.deliver_later
      end
    end
end
