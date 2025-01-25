module AdminDashboardPortal
  class HackerPolicy < ::HackerPolicy
    authorize :params, optional: true
    include AdminDashboardPortal::ResourcePolicy

    def permitted_attributes_for_read
      [:email]
    end

    # Scope hackers based on the team they belong to
    relation_scope do |relation|
      if params && params[:hackathon_team_id]
        team_id = params[:hackathon_team_id]
        relation.includes(:team).where(team: {id: team_id})
      else
        relation
      end
    end
  end
end
