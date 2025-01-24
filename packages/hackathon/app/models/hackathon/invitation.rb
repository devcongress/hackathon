# == Schema Information
#
# Table name: hackathon_invitations
#
#  id         :integer          not null, primary key
#  status     :interger         default("pending"), not null
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
  enum :status, pending: 0, sent: 1, accepted: 2, failed: 3

  before_validation :generate_token, :set_default_status

  belongs_to :team, class_name: "Hackathon::Team"
  belongs_to :profile, class_name: "Profile", optional: true

  validates :email, presence: true,
                    uniqueness: { scope: :team_id, message: "has already been invited" }
  validates :token, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  private

    def generate_token
      self.token ||= SecureRandom.urlsafe_base64(64)
    end

    def set_default_status
      self.status ||= :pending
    end
end
