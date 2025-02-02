module AdminDashboardPortal
  module Concerns
    module Controller
      extend ActiveSupport::Concern
      include Plutonium::Portal::Controller
      include Plutonium::Auth::Rodauth(:admin)
      # add concerns above.

      private

      def app_name = "Admin Dashboard | Hack! with Achieve by Petra"
    end
  end
end
