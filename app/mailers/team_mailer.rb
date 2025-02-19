class TeamMailer < ApplicationMailer
  before_action :set_details

  def qualified_email
    mail to: @recipient,
      subject: "Congratulations! 🎉 #{@team.name} Is Qualified for Hack! with achieve by Petra"
  end

  def late_qualified_email
    mail to: @recipient,
      subject: "Update on Your Team's Qualification Status for Hack! with achieve by Petra"
  end

  private

  def set_details
    @team = params[:team]
    @owner = @team.hacker
    @recipient = email_address_with_name(@owner.email, @owner.profile.name)

    @dashboard_portal_url = "#{root_url}hacker_dashboard"
  end
end
