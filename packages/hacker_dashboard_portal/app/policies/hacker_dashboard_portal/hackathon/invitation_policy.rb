class HackerDashboardPortal::Hackathon::InvitationPolicy < ::Hackathon::InvitationPolicy
  def create?
    false
  end

  def read?
    user.team_owner?
  end

  def destroy?
    !record.accepted?
  end

  def resend_invite?
    user.team_owner? && !record.accepted? && !record.declined?
  end

  def permitted_attributes_for_read
    [:email, :status]
  end

  private

  def team_hackers_less_than_5?
    user.team.hackers.count < 5
  end
end
