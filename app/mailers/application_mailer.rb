class ApplicationMailer < ActionMailer::Base
  default from: "UNICEF StartUp Lab Hack <hack25@devcongress.io>"
  layout "mailer"

  def self.hack_name
    "The UNICEF StartUp Lab Hack"
  end

  def self.event_date
    "Thursday, November 12, 2025"
  end

  def self.event_time
    "2pm GMT"
  end

  def self.location
    "[TBD]"
  end

  def self.location_map
    "[TBD]"
  end
end
