class AdminDashboardPortal::HackerDefinition < ::HackerDefinition
  index_page_description "Qalified team hackers can be checked in upon arrival"

  search do |scope, query|
    scope.joins(:profile)
      .where(
        "LOWER(profiles.name) LIKE LOWER(:query)
              OR LOWER(hackers.email) LIKE LOWER(:query)",
        query: "%#{query}%"
      )
  end

  action :export_hackers_to_csv,
    interaction: Hackers::Interactions::ExportHackersToCsvInteraction,
    resource_action: true,
    turbo: false,
    category: :primary
end
