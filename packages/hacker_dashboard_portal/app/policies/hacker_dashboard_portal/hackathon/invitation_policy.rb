class HackerDashboardPortal::Hackathon::InvitationPolicy < ::Hackathon::InvitationPolicy
  authorize :team

  def create?
    team_hackers_less_than_5? && user.owns_team?(team)
  end

  def read?
    user.owns_team?(team)
  end

  def destroy?
    return false if record.accepted?

    true
  end

  def resend_invite?
    # Allow re-sending invites when the initial invite failed
    user.owns_team?(team) && (record.failed? || record.pending?)
  end

  def permitted_attributes_for_read
    [ :email, :status ]
  end

  private

    def team_hackers_less_than_5?
      user.team.hackers.count < 5
    end
end
