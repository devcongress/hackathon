class Hackathon::InvitationDefinition < Hackathon::ResourceDefinition
  display :status, as: :string, formatter: ->(value) { value.titleize }

  action :resend_invite,
    interaction: Hackathon::Invitations::ResendInvite

  # index_page_title "Invited Hackers"
  new_page_title "Invite Hacker"
  show_page_title "Invited Hacker Details"
end
