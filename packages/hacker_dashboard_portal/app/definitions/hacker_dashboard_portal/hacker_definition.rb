class HackerDashboardPortal::HackerDefinition < ::HackerDefinition
  include HackerDashboardPortal::ResourceDefinition

  class IndexPage < IndexPage
    def render_breadcrumbs
    end
  end

  class ShowPage < ShowPage
    def render_breadcrumbs
    end
  end
end
