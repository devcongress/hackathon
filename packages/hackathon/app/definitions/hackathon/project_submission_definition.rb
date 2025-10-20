class Hackathon::ProjectSubmissionDefinition < Hackathon::ResourceDefinition
  field :about_project, as: :text,
    label: "About the Project",
    hint: "Describe your project: What problem does it solve? What features does it have? What makes it special?"
  display :about_project, wrapper: {class: "col-span-full"}

  field :about_team, as: :text,
    label: "About the Team",
    hint: "Tell us about your team: What brought you together? What's your story? What did you learn?"
  display :about_team, wrapper: {class: "col-span-full"}
end
