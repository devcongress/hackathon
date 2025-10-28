class EventMailer < ApplicationMailer
  before_action :set_event

  def event_published
    @hacker = params[:hacker]
    @recipient = email_address_with_name(@hacker.email, @hacker.profile.name)
    @dashboard_url = "#{root_url}hacker_dashboard/hackathon/events"

    # Generate and attach calendar invite
    calendar_invite = ::CalendarInviteService.new(@event).generate
    attachments["event.ics"] = {mime_type: "text/calendar", content: calendar_invite}

    mail to: @recipient,
      subject: "New Event: #{@event.title} - UNICEF StartUp Lab Hack"
  end

  private

  def set_event
    @event = params[:event]
  end
end
