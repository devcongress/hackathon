# == Schema Information
#
# Table name: hackathon_invited_hackers
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :integer          not null
#
# Indexes
#
#  index_hackathon_invited_hackers_on_email    (email) UNIQUE
#  index_hackathon_invited_hackers_on_team_id  (team_id)
#
# Foreign Keys
#
#  team_id  (team_id => hackathon_teams.id)
#
require_relative "../hackathon"

class Hackathon::InvitedHacker < Hackathon::ResourceRecord
  belongs_to :team, class_name: "Hackathon::Team"
  validates :email, presence: true, uniqueness: true

  scope(
    :associated_with_hacker,
    -> (hacker) {
      includes(:team).where(hackathon_teams: {hacker_id: hacker.id})
    }
  )
end
