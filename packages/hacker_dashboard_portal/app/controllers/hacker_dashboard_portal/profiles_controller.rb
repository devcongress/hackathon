class HackerDashboardPortal::ProfilesController < ::ProfilesController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_profile_complete, only: [ :new, :create ]

  def create
    @profile = ::Profile.new(profile_params.except(:team))
    invite_token = fetch_invite_token

    authorize_current! @profile

    # When the token key was fetched but the content is empty, there's a problem
    if invite_token && invite_token.empty?
      return redirect_to_new_profile_with_alert("The token could not be found!")
    end

    team = find_team(invite_token)
    @profile.team = team

    Rails.logger.debug "Profile info after authorize: #{@profile.inspect}"

    if @profile.save
      handle_successful_save(invite_token)
    else
      redirect_to_new_profile_with_alert(
        "There was an error while creating the profile.\n" \
        "#{@profile.errors.full_messages.join("\n")}"
      )
    end
  end

  private

    def profile_params
      params
        .expect(profile: [ :name, :role, :telephone_number, :team ])
        .merge({ hacker: current_user })
    end

    def fetch_invite_token
      Rails.cache.read("#{current_user.email}_invite_token")
    end

    def find_team(invite_token)
      @invited_hacker = Hackathon::Invitation.includes(:team)
                                             .find_by(token: invite_token)

      if @invited_hacker
        @invited_hacker.team
      else
        GlobalID::Locator.locate_signed(profile_params[:team])
      end
    end

    def handle_successful_save(invite_token)
      if invited_hacker?
        @invited_hacker.update!(accepted: true, profile: @profile)
        Rails.cache.delete(@invited_hacker.token)
      end

      redirect_to(@profile, notice: "Profile was successfully created.")
    end

    def redirect_to_new_profile_with_alert(message)
      redirect_to resource_url_for(::Profile, action: :new), alert: message
    end

    def invited_hacker?
      @invited_hacker
    end
end
