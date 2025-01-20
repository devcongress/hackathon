class Hackathon::TeamDefinition < Hackathon::ResourceDefinition
  class ShowPage < ShowPage
    def render_breadcrumbs
      if current_user.class == Admin
        super
      end
    end
  end
end
