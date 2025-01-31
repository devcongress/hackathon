class AdminDashboardPortal::HackerDefinition < ::HackerDefinition
  search do |scope, query|
    scope.joins(:profile)
         .where(
           "LOWER(profiles.name) LIKE LOWER(:query)
              OR LOWER(hackers.email) LIKE LOWER(:query)",
           query: "%#{query}%",
         )
  end
end
