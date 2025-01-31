# == Schema Information
#
# Table name: hackathon_team_memberships
#
#  id            :integer          not null, primary key
#  role          :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  hacker_id     :integer          not null
#  invitation_id :integer
#  team_id       :integer          not null
#
# Indexes
#
#  index_hackathon_team_memberships_on_hacker_id      (hacker_id) UNIQUE
#  index_hackathon_team_memberships_on_invitation_id  (invitation_id)
#  index_hackathon_team_memberships_on_team_id        (team_id)
#
# Foreign Keys
#
#  hacker_id      (hacker_id => hackers.id)
#  invitation_id  (invitation_id => hackathon_invitations.id)
#  team_id        (team_id => hackathon_teams.id)
#
require_relative "../hackathon"

class Hackathon::TeamMembership < Hackathon::ResourceRecord
  # add concerns above.

  enum :role,
    developer: 0,
    designer: 1,
    product: 2,
    marketing: 4

  # add model configurations above.

  belongs_to :hacker
  belongs_to :team, class_name: "Hackathon::Team"
  belongs_to :invitation, optional: true

  # add belongs_to associations above.

  # add has_one associations above.

  # add has_many associations above.

  # add attachments above.

  # add scopes above.

  validates :role, presence: true
  # add validations above.

  after_create :send_welcome_email
  after_create :mark_invitation_as_accepted
  after_create :run_team_qualification_checks
  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  def to_label
    team.name
  end

  def check_in_status
    hacker.check_in_status
  end

  # add methods above.

  private

  def send_welcome_email
    TeamMembershipMailer.with(membership: self).welcome_email.deliver_later
  end

  def mark_invitation_as_accepted
    return unless invitation

    invitation.accepted!
  end

  def run_team_qualification_checks
    team.run_qualification_checks
  end
end
