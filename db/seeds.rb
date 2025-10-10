return unless Rails.env.local?

password = BCrypt::Password.create("password")

Admin.create(email: "admin@email.com", password_hash: password, status: :verified)

@data = {
  acme_incorporated: {
    members: [
      {
        email: "joe@email.com", role: :product, owner: true,
        name: "John Doe", sex: "male", region: "Greater Accra"
      },
      {email: "esi@email.com", role: :designer, name: "Esi Puma", sex: "female", region: "Ashanti"},
      {email: "bob@email.com", role: :developer, name: "Bob Sickle", sex: "male", region: "Eastern"}
    ]
  },
  lex_corp: {
    members: [
      {
        email: "sally@email.com", role: :marketing, owner: true,
        name: "Sally Banks", sex: "female", region: "Volta"
      },
      {email: "kane@email.com", role: :designer, name: "Kane Rogers", sex: "male", region: "Greater Accra"},
      {email: "lisa@email.com", role: :developer, name: "Lisa Brooks", sex: "female", region: "Oti"}
    ]
  },
  hackers: {
    members: [
      {
        email: "bumble.bee@email.com", role: :developer, owner: true,
        name: "Bumble Bee", sex: "female", region: "Central"
      },
      {email: "grumble@email.com", role: :designer, name: "Grumble", sex: "male", region: "Greater Accra" }
    ]
  },
  coders: {
    members: [
      {
        email: "game@email.com", role: :designer, owner: true,
        name: "Ruddolf Game", sex: "male", region: "Greater Accra"
      }
    ]
  }
}

@data.each do |team, data|
  team_name = team.to_s.tr("_", " ").titleize

  data[:members].each do |member|
    hacker = Hacker.create!(email: member[:email], password_hash: password,
      status: :verified)

    # Randomly select 1-4 skillsets
    skillset_count = rand(1..4)
    random_skillsets = Profile::SKILLSETS.values.sample(skillset_count)

    # Generate a valid Ghanaian mobile number in E164 format
    ghana_mobile_prefixes = %w[20 23 24 26 27 28 50 54 55 56 57 59]
    phone_number = "+233#{ghana_mobile_prefixes.sample}#{rand(1000000..9999999)}"

    hacker.create_profile!(
      name: member[:name], region: member[:region], sex: member[:sex], telephone_number: phone_number,
      skillsets: random_skillsets
    )

    if member[:owner]
      hacker.create_team!(name: team_name, role: member[:role].to_s, hacker:)
    else
      hacker.create_team_membership!(team: Hackathon::Team.find_by(name: team_name), role: member[:role].to_s)
    end
  end
end
