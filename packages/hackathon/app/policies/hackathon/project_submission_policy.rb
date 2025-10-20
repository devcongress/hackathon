class Hackathon::ProjectSubmissionPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:team, :about_project, :about_team]
  end

  def permitted_attributes_for_read
    [:team, :about_project, :about_team]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
