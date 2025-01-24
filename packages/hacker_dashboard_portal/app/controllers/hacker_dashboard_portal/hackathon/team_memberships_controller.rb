class HackerDashboardPortal::Hackathon::TeamMembershipsController < ::Hackathon::TeamMembershipsController
  include HackerDashboardPortal::Concerns::Controller

  authorize :invitation, through: :current_invitation


  def current_invitation
    return unless cookies.encrypted[:invite_token]

    @invitation ||= ::Hackathon::Invitation.find_by!(token: cookies.encrypted[:invite_token])
  end

  def set_page_title(title)
    if title == "Create #{resource_class.model_name.human.titleize}"
      super("Join #{current_parent.name}")
    else
      super
    end
  end
end
