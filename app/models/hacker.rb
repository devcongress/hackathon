# == Schema Information
#
# Table name: hackers
#
#  id            :integer          not null, primary key
#  email         :string           not null
#  password_hash :string
#  status        :integer          default("unverified"), not null
#
# Indexes
#
#  index_hackers_on_email  (email) UNIQUE WHERE status IN (1, 2)
#
class Hacker < ResourceRecord
  include Rodauth::Rails.model(:hacker)

  has_one :owned_team, class_name: "Hackathon::Team", dependent: :destroy

  validates :email, presence: true
  has_one :profile, dependent: :destroy
  has_one :team_membership, dependent: :destroy,
                            class_name: "Hackathon::TeamMembership"
  has_one :team, through: :team_membership

  enum :status, unverified: 1, verified: 2, closed: 3

  def to_label
    profile.name
  end

  def owns_team?(team)
    team.hacker == self
  end
end
