class HackerDashboardPortal::TeamDefinition < ::Hackathon::TeamDefinition
  include HackerDashboardPortal::ResourceDefinition

  class ShowPage < ShowPage
    def render_breadcrumbs
    end
  end
end
