# == Schema Information
#
# Table name: hackathon_final_submissions
#
#  id                     :integer          not null, primary key
#  github_repo            :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  peoples_choice_vote_id :integer          not null
#  team_id                :integer          not null
#
# Indexes
#
#  index_hackathon_final_submissions_on_peoples_choice_vote_id  (peoples_choice_vote_id)
#  index_hackathon_final_submissions_on_team_id                 (team_id) UNIQUE
#
# Foreign Keys
#
#  peoples_choice_vote_id  (peoples_choice_vote_id => hackathon_teams.id)
#  team_id                 (team_id => hackathon_teams.id)
#
require_relative "../hackathon"

class Hackathon::FinalSubmission < Hackathon::ResourceRecord
  # add concerns above.

  # add model configurations above.

  belongs_to :team
  belongs_to :peoples_choice_vote, class_name: "Hackathon::Team"
  # add belongs_to associations above.

  # add has_one associations above.

  # add has_many associations above.

  # add attachments above.

  # add scopes above.

  validates :github_repo, presence: true, format: {with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL"}
  validates :team, uniqueness: true
  validate :team_must_be_invited
  validate :people_choice_vote_must_be_invited_team
  validate :cannot_vote_for_own_team
  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  def to_label
    "#{team.name} - Final Submission"
  end

  private

  def team_must_be_invited
    return if team&.invited?

    errors.add(:team, "must be invited to submit final project")
  end

  def people_choice_vote_must_be_invited_team
    return if peoples_choice_vote&.invited?

    errors.add(:peoples_choice_vote, "must be an invited team")
  end

  def cannot_vote_for_own_team
    return if peoples_choice_vote_id != team_id

    errors.add(:peoples_choice_vote, "cannot vote for your own team")
  end

  # add methods above.
end
