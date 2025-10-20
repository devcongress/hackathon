module Hackathon
  module Teams
    class InviteTeamInteraction < ResourceInteraction
      presents label: "Invite Team", icon: Phlex::TablerIcons::Mail
      attribute :resource

      private

      def execute
        resource.invite!

        success(resource)
          .with_message("#{resource.name} has been invited to the event")
      end
    end
  end
end
