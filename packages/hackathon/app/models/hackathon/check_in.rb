# == Schema Information
#
# Table name: hackathon_check_ins
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hacker_id  :integer          not null
#
# Indexes
#
#  index_hackathon_check_ins_on_hacker_id  (hacker_id)
#
# Foreign Keys
#
#  hacker_id  (hacker_id => hackers.id)
#
require_relative "../hackathon"

class Hackathon::CheckIn < Hackathon::ResourceRecord
  belongs_to :hacker
  has_one :team, through: :hacker

  def timestamp
    created_at
  end

  def to_label
    "#{hacker.profile.name} - #{hacker.team.name}"
  end
end
