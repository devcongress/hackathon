module Hackathon
  module Teams
    class SubmitProjectInteraction < ResourceInteraction
      presents label: "Submit Project", icon: Phlex::TablerIcons::FileText

      attribute :resource

      attribute :about_project
      field :about_project, as: :text,
        label: "About the Project",
        hint: "Describe your project: What problem does it solve? What features does it have? What makes it special?"

      attribute :about_team, as: :text
      field :about_team, as: :text,
        label: "About the Team",
        hint: "Tell us about your team: What brought you together? What's your story? What did you learn?"

      private

      def execute
        project_submission = resource.build_project_submission(
          about_project: about_project,
          about_team: about_team
        )

        if project_submission.save
          success(resource)
            .with_message("Project submission for #{resource.name} has been successfully created!")
        else
          failed(project_submission.errors)
        end
      end
    end
  end
end
