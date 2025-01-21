# == Schema Information
#
# Table name: hackathon_team_memberships
#
#  id         :integer          not null, primary key
#  role       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hacker_id  :integer          not null
#  team_id    :integer          not null
#
# Indexes
#
#  index_hackathon_team_memberships_on_hacker_id  (hacker_id) UNIQUE
#  index_hackathon_team_memberships_on_team_id    (team_id)
#
# Foreign Keys
#
#  hacker_id  (hacker_id => hackers.id)
#  team_id    (team_id => hackathon_teams.id)
#
require_relative "../hackathon"

class Hackathon::TeamMembership < Hackathon::ResourceRecord
  # add concerns above.

  # add model configurations above.

  belongs_to :hacker
  belongs_to :team, class_name: "Hackathon::Team"
  # add belongs_to associations above.

  # add has_one associations above.

  # add has_many associations above.

  # add attachments above.

  # add scopes above.

  validates :role, presence: true
  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  # add methods above.
end
