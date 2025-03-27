require "csv"

module Hackathon
  module Teams
    class ExportQualifiedTeamMembersInteraction < ResourceInteraction
      presents label: "Export to CSV", icon: Phlex::TablerIcons::Send

      private

      def execute
        file = Hackathon::Team.generate_csv_for_qualified_team_members

        if File.exist?(file)
          success(file)
            .with_file_response(
              file, type: "text/csv", disposition: "attachment",
                    filename: File.basename(file),
            )
        else
          failed("Failed to generate the CSV file, try again after some time")
        end
      end
    end
  end
end
