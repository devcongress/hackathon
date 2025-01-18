# == Schema Information
#
# Table name: profiles
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  role             :string           not null
#  telephone_number :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  hacker_id        :integer          not null
#  partner_id       :integer
#  team_id          :integer          not null
#
# Indexes
#
#  index_profiles_on_hacker_id   (hacker_id)
#  index_profiles_on_partner_id  (partner_id)
#  index_profiles_on_team_id     (team_id)
#
# Foreign Keys
#
#  hacker_id   (hacker_id => hackers.id)
#  partner_id  (partner_id => profiles.id)
#  team_id     (team_id => hackathon_teams.id)
#
class Profile < ::ResourceRecord
  belongs_to :team, class_name: "Hackathon::Team"
  belongs_to :hacker, class_name: "Hacker"

  has_many :partners, class_name: "Profile", dependent: :nullify
  belongs_to :partner, class_name: "Profile", optional: true

  validates :role, :name, presence: true

  enum(
    :role,
    developer: "Developer",
    designer: "Designer",
    product_manager: "Product Manager"
  )

  # self association (completes the partner association)
  scope :associated_with_profile, -> (profile) { where(team: profile.team) }

  # association with hacker (parent)
  scope :associated_with_hacker, -> (hacker) { where(team: hacker.team) }
end
