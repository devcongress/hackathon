class HackerDashboardPortal::Hackathon::ProjectSubmissionDefinition < ::Hackathon::ProjectSubmissionDefinition
  include HackerDashboardPortal::ResourceDefinition

  class Form < Form
    private

    def render_actions
      input name: "return_to", value: request.params[:return_to], type: :hidden, hidden: true

      actions_wrapper {
        render submit_button
      }
    end
  end

  new_page_title "Submit your team's project"
  edit_page_title "Edit your team's project"

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
