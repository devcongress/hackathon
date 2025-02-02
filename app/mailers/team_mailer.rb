class TeamMailer < ApplicationMailer
  before_action :set_details

  def qualified_email
    mail to: email_address_with_name(@owner.email, @owner.profile.name),
      subject: "✅ Team #{@team.name} Qualified! Next Steps to Hack! with Achieve by Petra"
  end

  private

  def set_details
    @team = params[:team]
    @owner = @team.hacker
  end
end
