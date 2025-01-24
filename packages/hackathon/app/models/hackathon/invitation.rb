# == Schema Information
#
# Table name: hackathon_invitations
#
#  id         :integer          not null, primary key
#  accepted   :boolean          default(FALSE), not null
#  email      :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer
#  team_id    :integer          not null
#
# Indexes
#
#  index_hackathon_invitations_on_email_and_team_id  (email,team_id) UNIQUE
#  index_hackathon_invitations_on_profile_id         (profile_id)
#  index_hackathon_invitations_on_team_id            (team_id)
#
# Foreign Keys
#
#  profile_id  (profile_id => profiles.id)
#  team_id     (team_id => hackathon_teams.id)
#
require_relative "../hackathon"

class Hackathon::Invitation < Hackathon::ResourceRecord
  belongs_to :team, class_name: "Hackathon::Team"
  validates :email, presence: true, uniqueness: {scope: :team_id, message: "has already been invited"}
  validates :token, presence: true
  validates :accepted, inclusion: {in: [true, false]}
  belongs_to :profile, class_name: "Profile", optional: true

  scope :associated_with_hacker,
    ->(hacker) {
      includes(:team).where(hackathon_teams: {hacker_id: hacker.id})
    }

  # An invite is accepted when a profile is associated with it
  def accepted
    profile.present?
  end
end
