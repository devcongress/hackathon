class HackerDashboardPortal::HackerDefinition < ::HackerDefinition
  include HackerDashboardPortal::ResourceDefinition

  index_page_breadcrumbs false

  class ShowPage < ShowPage
    include NavigatesBackToTeam
  end
end
