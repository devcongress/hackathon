module AdminDashboardPortal
  class HackerPolicy < ::HackerPolicy
    include AdminDashboardPortal::ResourcePolicy

    authorize :params, optional: true

    def export_hackers_to_csv?
      true
    end

    def check_in?
      !record.checked_in? && record&.team&.qualified?
    end

    def permitted_attributes_for_read
      [:name, :email, :check_in_status, :team]
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
