# == Schema Information
#
# Table name: profiles
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  region           :string
#  skillsets        :text
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
  SKILLSETS = {
    "Frontend Developer" => "frontend",
    "Backend Developer" => "backend",
    "Mobile Engineer" => "mobile",
    "Full Stack Developer" => "fullstack",
    "UI/UX Designer" => "designer",
    "Product Manager" => "product",
    "Data Scientist" => "data_science",
    "DevOps Engineer" => "devops"
  }.freeze

  REGIONS = [
    "Greater Accra",
    "Ashanti",
    "Western",
    "Western North",
    "Eastern",
    "Central",
    "Volta",
    "Oti",
    "Northern",
    "Savannah",
    "North East",
    "Upper East",
    "Upper West",
    "Bono",
    "Bono East",
    "Ahafo"
  ].freeze

  belongs_to :hacker
  has_one :team, through: :hacker
  has_one :emergency_contact, through: :hacker

  serialize :skillsets, coder: JSON

  validates :name, presence: true
  validates :telephone_number, presence: true, phone: {possible: true, types: :mobile}
  validates :skillsets, presence: true
  validates :region, presence: true, inclusion: {in: REGIONS}

  def telephone_number=(value)
    parsed = Phonelib.parse(value)
    super(parsed.valid? ? parsed.e164 : value)
  end

  def skillsets=(value)
    value = value.compact_blank if value.is_a?(Array)
    super
  end

  private

  def skillsets_must_be_valid
    return if skillsets.blank?

    invalid = skillsets - SKILLSETS.values
    errors.add(:skillsets, "contains invalid values: #{invalid.join(", ")}") if invalid.any?
  end
end
