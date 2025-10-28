class CalendarInviteService
  def initialize(event)
    @event = event
  end

  def generate
    calendar = Icalendar::Calendar.new

    calendar.event do |e|
      e.dtstart = Icalendar::Values::DateTime.new(@event.scheduled_at)
      e.dtend = Icalendar::Values::DateTime.new(@event.scheduled_at + (@event.duration || 60).minutes)
      e.summary = @event.title
      e.description = @event.description
      e.location = @event.meeting_link if @event.meeting_link.present?
      e.url = @event.meeting_link if @event.meeting_link.present?
      e.status = "CONFIRMED"
      e.organizer = Icalendar::Values::CalAddress.new("mailto:noreply@unicefstartuplab.org", cn: "UNICEF StartUp Lab Hack")
    end

    calendar.publish
    calendar.to_ical
  end
end
