class HackerDashboardPortal::Hackathon::TeamMembershipDefinition < ::Hackathon::TeamMembershipDefinition
  include HackerDashboardPortal::ResourceDefinition

  new_page_title -> {
    render_title "Join #{current_parent.name}"
  }
  edit_page_title "Update Membership Role"

  class NewPage < NewPage
    def render_breadcrumbs
    end
  end
end
