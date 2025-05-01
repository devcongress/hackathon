module AdminDashboardPortal
  module Hackathon
    class TeamPolicy < ::Hackathon::TeamPolicy
      def qualify_team?
        record.late_qualified?
      end

      def export_qualified_team_members?
        true
      end
    end
  end
end
