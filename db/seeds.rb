return unless Rails.env.local?

@password = BCrypt::Password.create("password")

@admin = Admin.create(email: "admin@email.com", password_hash: @password,
                      status: :verified)

@data = {
  thrusters: {
    members: [
      {
        email: "joe@email.com", role: :product_manager, owner: true,
        name: "John Doe"
      },
      { email: "esi@email.com", role: :designer, name: "Esi Puma" },
      { email: "bob@email.com", role: :developer, name: "Bob Sickle" }
    ]
  },
  curators: {
    members: [
      {
        email: "sally@email.com", role: :developer, owner: true,
        name: "Sally Banks"
      },
      { email: "kane@email.com", role: :designer, name: "Kane Rogers" },
      { email: "lisa@email.com", role: :developer, name: "Lisa Brooks" }
    ]
  }
}

@data.each do |team, data|
  @team_name = team.to_s.capitalize

  data[:members].each do |member|
    @hacker = Hacker.create!(email: member[:email], password_hash: @password,
                             status: :verified)
    if member[:owner]
      @team = Hackathon::Team.create!(name: @team_name, hacker_id: @hacker.id)
    end

    @profile = Profile.create!(
      name: member[:name], team: @team,
      hacker: @hacker, role: member[:role],
    )
  end
end
