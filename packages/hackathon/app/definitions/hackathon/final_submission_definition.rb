class Hackathon::FinalSubmissionDefinition < Hackathon::ResourceDefinition
  display :team, wrapper: {class: "col-span-full"}
  display :github_repo, as: :url, wrapper: {class: "col-span-full"}
  display :peoples_choice_vote, wrapper: {class: "col-span-full"}
end
