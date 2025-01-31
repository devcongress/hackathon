module Hackathon
  module CheckIns
    class CheckIn < ResourceInteraction
      presents label: "Check In", icon: Phlex::TablerIcons::Tent
      attribute :resource

      def execute
        check_in = Hackathon::CheckIn.new(hacker: resource)
        if check_in.save
          succeed(resource)
            .with_message(
              "#{resource.profile.name} has been successfully checked in."
            )
        else
          failed(check_in.errors)
        end
      end
    end
  end
end
