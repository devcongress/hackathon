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
#  index_hackathon_teams_on_hacker_id  (hacker_id) UNIQUE
#  index_hackathon_teams_on_name       (name) UNIQUE
#
# Foreign Keys
#
#  hacker_id  (hacker_id => hackers.id)
#
require_relative "../hackathon"

class Hackathon::Team < Hackathon::ResourceRecord
  has_many :hackers, class_name: "Profile", dependent: :destroy
  has_many :invited_hackers, class_name: "Hackathon::Invitation",
                             dependent: :destroy
  belongs_to :owner, class_name: "Hacker", foreign_key: "hacker_id"
  validates :name, presence: true, uniqueness: true

  scope :associated_with_hacker,
    ->(hacker) {
      includes(:hackers)
        .where(hacker_id: hacker.id)
        .or(where(hackers: { id: hacker.id }))
    }
end
