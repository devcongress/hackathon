class HackerDashboardPortal::Hackathon::FinalSubmissionDefinition < ::Hackathon::FinalSubmissionDefinition
  include HackerDashboardPortal::ResourceDefinition

  field :github_repo,
    hint: "URL to your project's GitHub repository",
    label: "GitHub Repository URL"

  field :peoples_choice_vote_id,
    hint: "Vote for your favorite project (cannot vote for your own team)",
    label: "People's Choice Vote"

  input :peoples_choice_vote_id do |builder|
    builder.select_tag choices: Hackathon::Team.invited.where.not(id: current_user.team.id).pluck(:name, :id)
  end

  class Form < Form
    private

    def render_actions
      input name: "return_to", value: request.params[:return_to], type: :hidden, hidden: true

      actions_wrapper {
        render submit_button
      }
    end
  end

  new_page_title "Submit your team's final project"
  edit_page_title "Edit your team's final project"

  class IndexPage < IndexPage
    include NavigatesBackToTeam
  end

  class ShowPage < ShowPage
    include NavigatesBackToTeam
  end

  class NewPage < NewPage
    include NavigatesBackToTeam
  end

  class EditPage < EditPage
    include NavigatesBackToTeam
  end
end
