class ApplicationMailer < ActionMailer::Base
  default from: "UNICEF StartUp Lab Hack <hack25@devcongress.io>"
  layout "mailer"

  def self.event_date
    "Thursday, November 12, 2025"
  end
end
