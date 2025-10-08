module HackerDashboardPortal
  class ProfilePolicy < ::ProfilePolicy
    include HackerDashboardPortal::ResourcePolicy

    def new?
      true
    end

    def create?
      user.profile.nil?
    end

    def update?
      user.profile == record
    end

    relation_scope do |relation|
      if user.team
        relation.joins(:team).where(hackathon_teams: {id: user.team.id})
      else
        relation
      end
    end

    def permitted_associations
      %i[emergency_contact] if user.profile == record
    end
  end
end
