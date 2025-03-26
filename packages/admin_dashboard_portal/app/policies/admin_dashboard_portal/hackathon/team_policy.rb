module AdminDashboardPortal
  module Hackathon
    class TeamPolicy < ::Hackathon::TeamPolicy
      def qualify_team?
        record.late_qualified?
      end
    end
  end
end
