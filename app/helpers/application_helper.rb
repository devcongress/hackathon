module ApplicationHelper
  RESOURCES = {
    "Team" => {
      icon: Phlex::TablerIcons::Users,
      description: "View team details, including members and their roles."
    },
    "Hacker" => {
      icon: Phlex::TablerIcons::User,
      description: "View all registered hackers and their details. Check in hackers to events."
    },
    "Invitation" => {
      icon: Phlex::TablerIcons::MailForward,
      description: "View and track invitations sent to potential team members."
    },
    "Check in" => {
      icon: Phlex::TablerIcons::CircleCheck,
      description: "View event check-in records and attendance history."
    }
  }.freeze

  def icon_for(name, style: "dark:stroke-white w-12 h-12")
    resource = RESOURCES[name]
    resource[:icon].new(class: style) if resource
  end

  def description_for(name)
    resource = RESOURCES[name]
    resource[:description] if resource
  end

  def event_duration
    "March 28-30, 2025"
  end
end
