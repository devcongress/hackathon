class AdminDashboardPortal::Hackathon::FinalSubmissionPolicy < ::Hackathon::FinalSubmissionPolicy
  def create?
    false
  end
end
