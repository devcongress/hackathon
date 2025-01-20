AdminDashboardPortal::Engine.routes.draw do
  root(to: "dashboard#index")

  register_resource(::Hackathon::Team)
  register_resource(::Hacker)
  register_resource(::Profile)
  register_resource ::Hackathon::Invitation
  # register resources above.

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end

# mount our app
Rails.application.routes.draw do
  constraints(Rodauth::Rails.authenticate(:admin)) do
    mount(AdminDashboardPortal::Engine, at: "/admin_dashboard")
  end
end
