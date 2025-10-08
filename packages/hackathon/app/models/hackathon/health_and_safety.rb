# == Schema Information
#
# Table name: hackathon_health_and_safeties
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  hacker_id    :integer          not null
#
# Indexes
#
#  index_hackathon_health_and_safeties_on_hacker_id  (hacker_id)
#
# Foreign Keys
#
#  hacker_id  (hacker_id => hackers.id)
#
require_relative "../hackathon"

class Hackathon::HealthAndSafety < Hackathon::ResourceRecord
  belongs_to :hacker

  validates :name, presence: true
  validates :phone_number, presence: true, phone: {possible: true, types: :mobile}
  validates :consent, acceptance: true

  def phone_number=(value)
    parsed = Phonelib.parse(value)
    super(parsed.valid? ? parsed.e164 : value)
  end

  def consented
    valid? ? "Accepted" : "Declined"
  end
end
