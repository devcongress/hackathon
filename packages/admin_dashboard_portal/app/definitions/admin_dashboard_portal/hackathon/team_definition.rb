class AdminDashboardPortal::Hackathon::TeamDefinition < ::Hackathon::TeamDefinition
  include AdminDashboardPortal::ResourceDefinition

  action :qualify_team,
    interaction: Hackathon::Teams::QualifyTeamInteraction,
    confirmation: "Are you sure you want to qualify this team?"
end
