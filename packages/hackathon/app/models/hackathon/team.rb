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

  MINIMUM_TEAM_MEMBERSHIPS = 2
  MAX_TEAM_MEMBERSHIPS = 4
  MAX_TEAM_THRESHOLD = 10

  belongs_to :hacker

  has_many :team_memberships, dependent: :destroy
  has_many :hackers, through: :team_memberships
  has_many :invitations,
    class_name: "Hackathon::Invitation", dependent: :destroy

  enum :status, unqualified: 0, qualified: 1, late_qualified: 2

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :status, presence: true,
    inclusion: {in: Hackathon::Team.statuses.keys}

  attribute :role
  validates :role, presence: true,
    inclusion: {in: Hackathon::TeamMembership.roles.keys}, on: :create

  after_create do
    team_memberships.create!(hacker:, role:)
  end

  def has_minimum_memberships?
    team_memberships.count >= MINIMUM_TEAM_MEMBERSHIPS
  end

  # Runs the qualification checks for the team and sends an email to the team
  # if they are qualified.
  #
  # A team is qualified if they have at least {MINIMUM_TEAM_MEMBERSHIPS} members.
  def run_qualification_checks
    return unless unqualified? && has_minimum_memberships?

    if limit_reached?
      late_qualify!
    elsif unqualified?
      qualify!
    end
  end

  def send_late_qualified_email
    TeamMailer.with(team: self).late_qualified_email.deliver_later
  end

  def send_qualified_email
    TeamMailer.with(team: self).qualified_email.deliver_later
  end

  def full?
    team_memberships.count == MAX_TEAM_MEMBERSHIPS
  end

  def limit_reached?
    Hackathon::Team.qualified.count >= MAX_TEAM_THRESHOLD
  end

  def qualify!
    qualified!
    send_qualified_email
  end

  def late_qualify!
    late_qualified!
    send_late_qualified_email
  end

  def self.generate_csv_for_qualified_team_members
    headers = %w[hacker_name email team_name]
    file = Rails.root.join("tmp/qualified_team_members_#{DateTime.now}.csv").to_s

    CSV.open(file, "w", write_headers: true, headers: headers) do |writer|
      qualified.each do |team|
        team.hackers.each do |hacker|
          writer << [hacker.profile.name, hacker.email, team.name]
        end
      end
    end

    file
  end
end
