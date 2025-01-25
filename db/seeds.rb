return unless Rails.env.local?

password = BCrypt::Password.create("password")

Admin.create(email: "admin@email.com", password_hash: password,
  status: :verified)

@data = {
  acme_incorporated: {
    members: [
      {
        email: "joe@email.com", role: :product_manager, owner: true,
        name: "John Doe"
      },
      {email: "esi@email.com", role: :designer, name: "Esi Puma"},
      {email: "bob@email.com", role: :developer, name: "Bob Sickle"}
    ]
  },
  lex_corp: {
    members: [
      {
        email: "sally@email.com", role: :developer, owner: true,
        name: "Sally Banks"
      },
      {email: "kane@email.com", role: :designer, name: "Kane Rogers"},
      {email: "lisa@email.com", role: :developer, name: "Lisa Brooks"}
    ]
  },
  hackers: {
    members: [
      {
        email: "bumble.bee@email.com", role: :developer, owner: true,
        name: "Bumble Bee"
      },
      {email: "grumble@email.com", role: :designer, name: "Grumble"}
    ]
  },
  coders: {
    members: [
      {
        email: "game@email.com", role: :designer, owner: true,
        name: "Ruddolf Game"
      }
    ]
  }
}

@data.each do |team, data|
  team_name = team.to_s.tr("_", " ").titleize

  data[:members].each do |member|
    hacker = Hacker.create!(email: member[:email], password_hash: password,
      status: :verified)

    Profile.create!(
      name: member[:name], hacker: hacker,
      telephone_number: Faker::PhoneNumber.phone_number_with_country_code
    )

    if member[:owner]
      team = Hackathon::Team.create!(name: team_name, hacker: hacker,
        role: member[:role].to_s)
    else
      Hackathon::TeamMembership.create!(team: team, hacker: hacker,
        role: member[:role].to_s)
    end
  end
end
