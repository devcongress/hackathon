module Hackathon
  module Invitations
    class Invite < ResourceInteraction
      presents label: "Invite", icon: Phlex::TablerIcons::Message
      attribute :resource

      def execute
        if InvitedHackerMailer.with(hacker: resource).send_invite.deliver_later
          succeed(resource).with_message("Invitation was successfully sent")
        else
          failed(resource.errors)
        end
      end
    end
  end
end
