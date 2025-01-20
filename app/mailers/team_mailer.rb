class TeamMailer < ApplicationMailer
  def validated
    @team = params[:team]
    @owner = @team.owner

    mail to: email_address_with_name(@owner.email, @owner.profile.name),
         subject: "Your Team '#{@team.name}' is Ready!"
  end
end
