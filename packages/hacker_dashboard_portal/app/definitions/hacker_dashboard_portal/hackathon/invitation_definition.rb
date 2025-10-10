class HackerDashboardPortal::Hackathon::InvitationDefinition < ::Hackathon::InvitationDefinition
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

  class IndexPage < IndexPage
    include NavigatesBackToTeam
  end

  class ShowPage < ShowPage
    include NavigatesBackToTeam
  end

  class EditPage < EditPage
    include NavigatesBackToTeam
  end
end
