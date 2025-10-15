module HackerDashboardPortal
  module Concerns
    module Controller
      extend ActiveSupport::Concern
      include Plutonium::Portal::Controller
      include Plutonium::Auth::Rodauth(:hacker)
      # add concerns above.

      included do
        before_action :ensure_profile_created
        before_action :ensure_profile_completed
        before_action :ensure_emergency_contact_exists
        before_action :ensure_joined_team
        before_action :check_pending_invitation
      end

      private

      def app_name = "UNICEF StartUp Lab Hack"

      def ensure_profile_created
        if current_user.profile.nil?
          redirect_to(resource_url_for(Profile, action: :new))
        end
      end

      def ensure_profile_completed
        if current_user.profile.present? && !current_user.profile.completed?
          redirect_to(resource_url_for(current_user.profile, action: :edit))
        end
      end

      def ensure_joined_team
        # if current_user.team.nil?
        #   redirect_to(resource_url_for(::Hackathon::Team, action: :new))
        # end
      end

      def ensure_emergency_contact_exists
        if current_user.emergency_contact.nil?
          redirect_to resource_url_for(::Hackathon::HealthAndSafety, action: :new)
        end
      end

      def current_invitation
        return unless cookies.encrypted[:invite_token]

        @invitation ||= ::Hackathon::Invitation.find_by(
          token: cookies.encrypted[:invite_token]
        )
      end

      # Complete team membership for invited hacker by allowing them select
      # their role in the team.
      def check_pending_invitation
        return unless current_invitation&.usable?

        redirect_to resource_url_for(
          ::Hackathon::TeamMembership, action: :new,
          parent: current_invitation.team
        )
      end
    end
  end
end
