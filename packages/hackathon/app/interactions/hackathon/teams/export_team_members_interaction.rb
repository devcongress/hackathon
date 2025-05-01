require "csv"

module Hackathon
  module Teams
    class ExportTeamMembersInteraction < ResourceInteraction
      presents label: "Export Registered Hackers to CSV",
        icon: Phlex::TablerIcons::FileExport

      private

      def execute
        file = Hackathon::Team.generate_csv_for_team_members

        if File.exist?(file)
          success(file).with_file_response(
            file, type: "text/csv", disposition: "attachment",
            filename: File.basename(file)
          )
        else
          failed("Failed to generate the CSV file, try again after some time")
        end
      end
    end
  end
end
