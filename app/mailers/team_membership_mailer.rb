class TeamMembershipMailer < ApplicationMailer
  before_action :set_details

  def welcome_email
    mail to: email_address_with_name(@hacker.email, @hacker.profile.name),
      subject: "🌟 Welcome to Hack! with Achieve by Petra, #{@hacker.profile.name}! 🚀"
  end

  private

  def set_details
    @membership = params[:membership]
    @hacker = @membership.hacker
    @team = @membership.team
    @owner = @team.hacker
  end
end
