HackerDashboardPortal::Engine.routes.draw do
  root "dashboard#index" # redirect("/hacker_dashboard/hackathon_team")

  register_resource ::Hacker
  register_resource ::Hackathon::Team
  register_resource ::Profile, singular: true
  register_resource ::Hackathon::Invitation
  register_resource ::Hackathon::TeamMembership
  # register resources above.

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end

# mount our app
Rails.application.routes.draw do
  constraints Rodauth::Rails.authenticate(:hacker) do
    mount HackerDashboardPortal::Engine, at: "/hacker_dashboard"
  end
end
