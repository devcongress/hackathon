class Hackathon::InvitationPolicy < Hackathon::ResourcePolicy
  # Core actions

  # Set the constraint to allow only up to 4 invitation per team
  def new?
    return if admin?

    team_hackers_less_than_5?
  end

  def create?
    hacker? && user.owns_team?(record.team)
  end

  def read?
    true
  end

  def index?
    admin? || (hacker? && user.owned_team.present?)
  end

  # Allow hackers to re-send invitations to invited hackers
  def invite?
    # Avoid sending invitations to already joined hackers
    return false if record.accepted?

    hacker? && user.owns_team?(record.team)
  end

  # Core attributes

  def permitted_attributes_for_create
    [ :email ]
  end

  def permitted_attributes_for_read
    if admin?
      [ :email, :accepted, :team ]
    else
      [ :email, :accepted ]
    end
  end

  # Associations

  def permitted_associations
    %i[profile]
  end

  private

    def team_hackers_less_than_5?
      user.team.hackers.count < 5
    end
end
