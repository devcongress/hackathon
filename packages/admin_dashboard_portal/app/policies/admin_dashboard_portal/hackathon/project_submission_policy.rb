class AdminDashboardPortal::Hackathon::ProjectSubmissionPolicy < ::Hackathon::ProjectSubmissionPolicy
  def create?
    false
  end
end
