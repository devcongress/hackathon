module HackerDashboardPortal
  class HackerPolicy < ::HackerPolicy
    include HackerDashboardPortal::ResourcePolicy

    def permitted_attributes_for_read
      [:email]
    end

    def permitted_associations
      if user == record
        %i[profile team emergency_contact]
      else
        %i[profile team]
      end
    end

    # Scope hackers based on the team they belong to
    relation_scope do |relation|
      next relation unless entity_scope

      relation.includes(:team).where(team: {id: user.team.id})
    end
  end
end
