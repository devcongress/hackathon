module HackerDashboardPortal
  class Engine < Rails::Engine
    include Plutonium::Portal::Engine
    # add concerns above.

    config.after_initialize do
      scope_to_entity ::Hacker, strategy: :current_user
    end
  end
end
