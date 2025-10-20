# == Schema Information
#
# Table name: hackathon_project_submissions
#
#  id            :integer          not null, primary key
#  about_project :text             not null
#  about_team    :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  team_id       :integer          not null
#
# Indexes
#
#  index_hackathon_project_submissions_on_team_id  (team_id) UNIQUE
#
# Foreign Keys
#
#  team_id  (team_id => hackathon_teams.id)
#
require_relative "../hackathon"

class Hackathon::ProjectSubmission < Hackathon::ResourceRecord
  # add concerns above.

  # add model configurations above.

  belongs_to :team
  # add belongs_to associations above.

  # add has_one associations above.

  # add has_many associations above.

  # add attachments above.

  # add scopes above.

  validates :about_project, presence: true
  validates :about_team, presence: true
  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  def to_label
    "#{team.name} - Project Submission"
  end
  # add methods above.
end
