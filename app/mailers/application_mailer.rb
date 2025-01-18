class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("no-reply@hackathon.com", "Hackathon Team")
  layout "mailer"
end
