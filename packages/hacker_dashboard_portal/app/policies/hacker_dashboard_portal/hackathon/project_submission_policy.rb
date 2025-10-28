class HackerDashboardPortal::Hackathon::ProjectSubmissionPolicy < ::Hackathon::ProjectSubmissionPolicy
  def new?
    true
  end

  def create?
    user.owns_team?(user.team) && user.team.project_submission.nil?
  end

  def read?
    # Can read their own team's submission
    user.team == record.team
  end

  def update?
    # Only team owners can update their team's submission
    user.owns_team?(record.team)
  end

  # Scope to only show the current user's team submission
  relation_scope do |relation|
    if user.team.present?
      relation.where(team_id: user.team.id)
    else
      relation.none
    end
  end

  def permitted_attributes_for_read
    %i[about_project about_team]
  end

  def permitted_attributes_for_create
    %i[about_project about_team]
  end
end
