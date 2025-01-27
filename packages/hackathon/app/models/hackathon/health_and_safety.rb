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
  # add concerns above.

  # add model configurations above.

  belongs_to :hacker
  # add belongs_to associations above.

  # add has_one associations above.

  # add has_many associations above.

  # add attachments above.

  # add scopes above.

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :consent, acceptance: true

  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  def consent
    if name.present? && phone_number.present?
      "Accepted"
    else
      "Declined"
    end
  end

  # add methods above.
end
