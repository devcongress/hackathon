module AdminDashboardPortal
  module Hackathon
    class TeamPolicy < ::Hackathon::TeamPolicy
      def qualify_team?
        record.late_qualified?
      end

      def invite_team?
        record.qualified? && record.project_submission.present?
      end

      def export_qualified_team_members?
        true
      end
    end
  end
end
