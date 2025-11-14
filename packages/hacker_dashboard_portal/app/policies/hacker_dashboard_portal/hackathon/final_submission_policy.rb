class HackerDashboardPortal::Hackathon::FinalSubmissionPolicy < ::Hackathon::FinalSubmissionPolicy
  def new?
    true
  end

  def create?
    user.team.invited? && user.owns_team?(user.team) && user.team.final_submission.nil?
  end

  def read?
    # Can read their own team's submission
    user.team == record.team
  end

  def update?
    user.owns_team?(record.team) && record.team.final_submission.present?
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
    %i[github_repo peoples_choice_vote]
  end

  def permitted_attributes_for_create
    %i[github_repo peoples_choice_vote_id]
  end
end
