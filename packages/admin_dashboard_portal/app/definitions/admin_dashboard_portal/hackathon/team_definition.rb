class AdminDashboardPortal::Hackathon::TeamDefinition < ::Hackathon::TeamDefinition
  include AdminDashboardPortal::ResourceDefinition

  action :qualify_team,
    interaction: Hackathon::Teams::QualifyTeamInteraction,
    confirmation: "Are you sure you want to qualify this team?"

  action :export_qualified_team_members,
    interaction: Hackathon::Teams::ExportQualifiedTeamMembersInteraction,
    resource_action: true,
    category: :primary,
    turbo: false
end
