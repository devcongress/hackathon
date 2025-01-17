module AdminDashboardPortal
  class Engine < Rails::Engine
    include Plutonium::Portal::Engine
    # add concerns above.

    config.after_initialize do
      # add directives above.
      # scope_to_entity ::Hackathon::Team, strategy: :current_user
    end
  end
end
