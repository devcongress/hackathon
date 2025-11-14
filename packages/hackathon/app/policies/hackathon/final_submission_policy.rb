class Hackathon::FinalSubmissionPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:github_repo, :peoples_choice_vote_id]
  end

  def permitted_attributes_for_read
    [:team, :github_repo, :peoples_choice_vote]
  end

  def permitted_attributes_for_update
    [:github_repo, :peoples_choice_vote_id]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
