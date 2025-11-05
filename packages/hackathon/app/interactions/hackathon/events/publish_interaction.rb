module Hackathon
  module Events
    class PublishInteraction < ResourceInteraction
      presents label: "Publish Event", icon: Phlex::TablerIcons::Send

      attribute :resource

      private

      def execute
        # Validate event has required fields for publishing
        if resource.meeting_link.blank?
          resource.errors.add(:meeting_link, "must be provided before publishing")
          return failed(resource.errors)
        end

        # Change status to published
        resource.published!

        # Only send emails for upcoming events, not past events
        if resource.upcoming?
          SendEventEmailsJob.perform_later(resource.id)
          success(resource)
            .with_message("#{resource.title} has been published! Emails are being sent to all hackers.")
        else
          success(resource)
            .with_message("#{resource.title} has been published! (No emails sent for past events)")
        end
      end
    end
  end
end
