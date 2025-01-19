class Hackathon::InvitationPolicy < Hackathon::ResourcePolicy
  # Core actions

  # Set the constraint to allow only up to 4 invitation per team
  def new?
    hacker? && user.team.invited_hackers.count < 4
  end

  def create?
    hacker? && user.owns_team?(record.team)
  end

  def read?
    true
  end

  def index?
    admin? || hacker? && user.owned_team.present?
  end

  # Allow hackers to re-send invitations to invited hackers
  def invite?
    hacker? && user.owns_team?(record.team)
  end

  # Core attributes

  def permitted_attributes_for_create
    [ :email ]
  end

  def permitted_attributes_for_read
    [ :email, :accepted ]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
