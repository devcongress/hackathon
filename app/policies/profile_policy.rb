class ProfilePolicy < ::ResourcePolicy
  # Core actions
  def new?
    hacker? && user.profile.nil?
  end

  def create?
    true
  end

  def read?
    true
  end

  def update?
    hacker? && user.profile == record
  end

  def destroy?
    update?
  end

  # Core attributes

  def permitted_attributes_for_create(invite_token_present: false)
    if invite_token_present
      [ :team, :name, :role, :telephone_number ]
    else
      # Do not show the team field for hackers joining from an invite
      # They will be joined automatically to the team they were invited to
      [ :name, :role, :telephone_number ]
    end
  end

  def permitted_attributes_for_edit
    [ :name, :role, :telephone_number ]
  end

  def permitted_attributes_for_read
    if admin?
      %i[name role telephone_number team]
    else
      %i[name role telephone_number]
    end
  end

  # Associations

  def permitted_associations
    %i[team partners]
  end
end
