module Hackathon
  module Teams
    class InviteMember < ResourceInteraction
      presents label: "Invite Member", icon: Phlex::TablerIcons::Message
      attribute :resource

      attribute :email
      field :email, hint: "Your team member's email address"
      validates :email, presence: true

      def execute
        invitation = Hackathon::Invitation.new(email:, team: resource)
        if invitation.save
          succeed(resource).with_message("Invitation sent to <#{invitation.email}>")
        else
          failed(invitation.errors)
        end
      end
    end
  end
end
