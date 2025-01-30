module AdminDashboardPortal
  module Concerns
    module Controller
      extend ActiveSupport::Concern
      include Plutonium::Portal::Controller
      include Plutonium::Auth::Rodauth(:admin)
      # add concerns above.

      private

      def make_page_title(title, app_name: "Admin Dashboard | Hack by Achieve")
        super
      end
    end
  end
end
