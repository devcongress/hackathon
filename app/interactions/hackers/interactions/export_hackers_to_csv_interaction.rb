require "csv"

module Hackers
  module Interactions
    class ExportHackersToCsvInteraction < ResourceInteraction
      presents label: "Export to CSV", icon: Phlex::TablerIcons::FileExport

      private

      def execute
        file = Hacker.to_csv

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
