# == Schema Information
#
# Table name: hackathon_events
#
#  id           :integer          not null, primary key
#  description  :text             not null
#  duration     :integer
#  event_type   :integer          default("workshop"), not null
#  meeting_link :string
#  scheduled_at :datetime         not null
#  status       :integer          default("draft"), not null
#  title        :string           not null
#  video_url    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_hackathon_events_on_scheduled_at  (scheduled_at)
#  index_hackathon_events_on_status        (status)
#
require_relative "../hackathon"

class Hackathon::Event < Hackathon::ResourceRecord
  # add concerns above.

  enum :status, {draft: 0, published: 1}
  enum :event_type, {workshop: 0, info_session: 1}
  # add model configurations above.

  # add belongs_to associations above.

  # add has_one associations above.

  # add has_many associations above.

  # add attachments above.

  scope :published, -> { where(status: :published) }
  scope :upcoming, -> { published.where("scheduled_at > ?", Time.current).order(scheduled_at: :asc) }
  scope :past, -> { published.where("scheduled_at <= ?", Time.current).order(scheduled_at: :desc) }
  # add scopes above.

  validates :title, presence: true
  validates :description, presence: true
  validates :event_type, presence: true
  validates :scheduled_at, presence: true
  validates :status, presence: true
  validates :meeting_link, presence: true, if: -> { published? }
  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  def past?
    scheduled_at <= Time.current
  end

  def upcoming?
    scheduled_at > Time.current
  end
  # add methods above.
end
