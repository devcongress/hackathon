# == Schema Information
#
# Table name: hackathon_teams
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  status     :integer          default("unqualified"), not null
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
  dynamic_path_parameter :name

  belongs_to :hacker

  has_many :team_memberships, dependent: :destroy
  has_many :hackers, through: :team_memberships
  has_many :invitations,
    class_name: "Hackathon::Invitation", dependent: :destroy

  enum :status, unqualified: 0, qualified: 1

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :status, presence: true, inclusion: {
    in: Hackathon::Team.statuses.keys
  }

  attribute :role
  validates :role, presence: true, inclusion: {
    in: Hackathon::TeamMembership.roles.keys
  }, on: :create

  after_create do
    team_memberships.create!(hacker:, role:)
  end

  def has_minimum_memberships?
    team_memberships.count >= 3
  end

  def run_qualification_checks
    return unless unqualified? && has_minimum_memberships?

    TeamMailer.with(team: self).qualified_email.deliver_later
    qualified!
  end

  def self.with_minimum_memberships
    joins(:team_memberships)
      .group("hackathon_team_memberships.team_id")
      .having("COUNT(hackathon_team_memberships.id) >= ?", 3)
  end
end
