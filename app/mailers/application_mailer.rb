class ApplicationMailer < ActionMailer::Base
  default from: "Hack! with achieve by Petra <hackathon@theachieveapp.com>"
  layout "mailer"

  def self.event_date
    "Friday, March 28, 2025"
  end
end
