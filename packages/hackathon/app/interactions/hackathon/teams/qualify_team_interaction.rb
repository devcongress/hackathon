module Hackathon
  module Teams
    class QualifyTeamInteraction < ResourceInteraction
      presents label: "Qualify Team", icon: Phlex::TablerIcons::Star
      attribute :resource

      private

      def execute
        if resource.late_qualified?
          resource.qualified!
          resource.send_qualified_email

          success(resource)
            .with_message("#{resource.name} has been administratively qualified")
        else
          failed("Team does not meet minimum requirements")
        end
      end
    end
  end
end
