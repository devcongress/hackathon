class SendEventEmailsJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Hackathon::Event.find(event_id)

    Rails.logger.info { "Sending event emails for: #{event.title}" }

    # Send email to all hackers with calendar invite
    Hacker.find_each do |hacker|
      EventMailer.with(event: event, hacker: hacker).event_published.deliver_later
    end

    Rails.logger.info { "Queued #{Hacker.count} emails for event: #{event.title}" }
  end
end
