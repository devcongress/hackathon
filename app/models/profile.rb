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
  belongs_to :hacker
  has_one :team, through: :hacker

  validates :name, presence: true
  validates :telephone_number, presence: true
end
