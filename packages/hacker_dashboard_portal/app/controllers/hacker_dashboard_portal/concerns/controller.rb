module HackerDashboardPortal
  module Concerns
    module Controller
      extend ActiveSupport::Concern
      include Plutonium::Portal::Controller
      include Plutonium::Auth::Rodauth(:hacker)
      # add concerns above.

      included do
        before_action :ensure_profile_complete
        before_action :ensure_emergency_contact_exists
        before_action :ensure_joined_team
      end

      private

      def app_name = "UNICEF StartUp Lab Hack"

      def ensure_profile_complete
        if current_user.profile.nil?
          redirect_to(resource_url_for(Profile, action: :new))
        end
      end

      def ensure_joined_team
        if current_user.team.nil?
          redirect_to(resource_url_for(::Hackathon::Team, action: :new))
        end
      end

      def ensure_emergency_contact_exists
        if current_user.emergency_contact.nil?
          redirect_to resource_url_for(::Hackathon::HealthAndSafety, action: :new)
        end
      end
    end
  end
end
