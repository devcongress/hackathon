module Hackathon
  module Invitations
    class ResendInvite < ResourceInteraction
      presents label: "Resend Invite", icon: Phlex::TablerIcons::Message
      attribute :resource

      def execute
        resource.send_invitation
        succeed(resource).with_message("Invitation was successfully sent to <#{resource.email}>")
      end
    end
  end
end
