# == Schema Information
#
# Table name: hackathon_teams
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hacker_id  :integer          not null
#
# Indexes
#
#  index_hackathon_teams_on_LOWER_name  (LOWER(name)) UNIQUE
#  index_hackathon_teams_on_hacker_id   (hacker_id) UNIQUE
#
# Foreign Keys
#
#  hacker_id  (hacker_id => hackers.id)
#
require_relative "../hackathon"

class Hackathon::Team < Hackathon::ResourceRecord
  belongs_to :hacker

  has_many :team_memberships, dependent: :destroy
  has_many :hackers, through: :team_memberships
  has_many :invitations, class_name: "Hackathon::Invitation",
                         dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  attribute :role
  validates :role, presence: true,
                   inclusion: { in: Hackathon::TeamMembership.roles.keys },
                   on: :create

  after_create do
    team_memberships.create!(hacker: hacker, role:)
  end
end
