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
  has_one :emergency_contact, class_name: "Hackathon::HealthAndSafety",
                              dependent: :destroy

  enum :status, unverified: 1, verified: 2, closed: 3

  def to_label
    profile.name
  end

  def team_owner? = owns_team?(team)

  def owns_team?(team)
    team.id == owned_team&.id
  end

  def name
    profile.name
  end

  def checked_in?
    Hackathon::CheckIn.pluck(:hacker_id).include? self.id
  end

  def check_in_status
    if checked_in?
      "Checked in"
    else
      "Pending"
    end
  end
end
