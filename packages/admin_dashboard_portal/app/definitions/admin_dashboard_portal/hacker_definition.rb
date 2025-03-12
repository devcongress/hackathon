class AdminDashboardPortal::HackerDefinition < ::HackerDefinition
  index_page_title "Hackers & Check In"

  index_page_description "Validated team  hackers can be checked in upon " \
                         "arrival. Use the 'Check In' action only when needed."

  search do |scope, query|
    scope.joins(:profile)
      .where(
        "LOWER(profiles.name) LIKE LOWER(:query)
              OR LOWER(hackers.email) LIKE LOWER(:query)",
        query: "%#{query}%"
      )
  end
end
