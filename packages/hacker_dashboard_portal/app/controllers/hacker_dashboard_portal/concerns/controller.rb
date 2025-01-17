module HackerDashboardPortal
  module Concerns
    module Controller
      extend ActiveSupport::Concern
      include Plutonium::Portal::Controller
      include Plutonium::Auth::Rodauth(:hacker)
      # add concerns above.

      included do
        before_action :ensure_profile_complete
      end

      private

      def ensure_profile_complete
        if current_user.class == Hacker && !current_user.profile
          redirect_to(resource_url_for(Profile, action: :new))
        end
      end
    end
  end
end
