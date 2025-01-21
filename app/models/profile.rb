# == Schema Information
#
# Table name: profiles
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  telephone_number :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  hacker_id        :integer          not null
#
# Indexes
#
#  index_profiles_on_hacker_id  (hacker_id) UNIQUE
#
# Foreign Keys
#
#  hacker_id  (hacker_id => hackers.id)
#
class Profile < ::ResourceRecord
  belongs_to :hacker, class_name: "Hacker"
  # has_many :partners, class_name: "Profile"

  # # self association (completes the partner association)
  # scope :associated_with_profile, ->(profile) { where(team: profile.team) }

  # # association with hacker (parent)
  # scope :associated_with_hacker, ->(hacker) { where(team: hacker.team) }
end
