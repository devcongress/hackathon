class Hackathon::InvitationDefinition < Hackathon::ResourceDefinition
  action :invite,
         interaction: Hackathon::Invitations::Invite

  # index_page_title "Invited Hackers"
  new_page_title "Invite Hacker"
  show_page_title "Invited Hacker Details"
end
