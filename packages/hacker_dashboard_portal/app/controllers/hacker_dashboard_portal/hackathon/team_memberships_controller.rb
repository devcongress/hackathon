class HackerDashboardPortal::Hackathon::TeamMembershipsController < ::Hackathon::TeamMembershipsController
  include HackerDashboardPortal::Concerns::Controller

  authorize :invitation, through: :current_invitation

  skip_before_action :ensure_joined_team, only: [:new, :create]
  skip_before_action :check_pending_invitation, only: [:new, :create]

  def present_scoped_entity? = true

  def new
    authorize_current! resource_class

    unless current_user.team.nil?
      redirect_to root_path
      return
    end

    super
  end

  private

  def resource_params
    @my_resource_params ||= begin
      input_params = super
      input_params[:invitation] = current_invitation if current_invitation
      input_params
    end
  end

  def redirect_url_after_submit
    if (return_to = url_from(params[:return_to]))
      return return_to
    end

    if action_name == "create"
      resource_url_for(resource_record!.team)
    else
      super
    end
  end
end
