# == Schema Information
#
# Table name: hackathon_health_and_safeties
#
#  id           :integer          not null, primary key
#  consent      :integer          default("no"), not null
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
  # TODO: Fix the issue with the enums when creating a new record
  enum :consent, no: 0, yes: 1
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
  validates :consent, presence: true
  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  # add methods above.
end
