module Hackathon
  module Teams
    class QualifyTeamInteraction < ResourceInteraction
      presents label: "Qualify Team", icon: Phlex::TablerIcons::Star
      attribute :resource

      private

      def execute
        resource.qualify!

        success(resource)
          .with_message("#{resource.name} has been administratively qualified")
      end
    end
  end
end
