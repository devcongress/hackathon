class Hackathon::TeamPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    false
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:name, :hacker]
  end

  def permitted_attributes_for_read
    [:name, :hacker, :status]
  end

  # Associations

  def permitted_associations
    if record.project_submission
      if record.final_submission
        %i[final_submission project_submission team_memberships invitations]
      else
        %i[project_submission team_memberships invitations]
      end
    else
      %i[team_memberships invitations]
    end
  end
end
