class AdminDashboardPortal::Hackathon::FinalSubmissionDefinition < ::Hackathon::FinalSubmissionDefinition
  class IndexPage < IndexPage
    private

    def render_after_toolbar
      # Calculate vote tallies
      vote_counts = Hackathon::FinalSubmission
        .group(:peoples_choice_vote_id)
        .count
        .sort_by { |_team_id, count| -count }

      winner_team_id, winner_votes = vote_counts.first
      winner_team = Hackathon::Team.find_by(id: winner_team_id) if winner_team_id

      div class: "mb-4 p-6 bg-gradient-to-r from-yellow-50 to-amber-50 dark:from-yellow-900/20 dark:to-amber-900/20 rounded-xl shadow-md border-2 border-yellow-200 dark:border-yellow-800" do
        div class: "flex items-start gap-4" do
          div class: "flex-shrink-0" do
            div class: "w-14 h-14 bg-yellow-500 dark:bg-yellow-600 rounded-full flex items-center justify-center" do
              svg class: "w-8 h-8 text-white", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do |s|
                s.path stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"
              end
            end
          end
          div class: "flex-1" do
            h3 class: "text-xl font-bold text-yellow-900 dark:text-yellow-100 mb-2" do
              "🏆 People's Choice Winner"
            end
            if winner_team
              p class: "text-lg font-semibold text-yellow-800 dark:text-yellow-200 mb-1" do
                winner_team.name
              end
              p class: "text-sm text-yellow-700 dark:text-yellow-300" do
                "#{winner_votes} #{winner_votes == 1 ? 'vote' : 'votes'} received"
              end
            else
              p class: "text-yellow-800 dark:text-yellow-200" do
                "No votes cast yet"
              end
            end
          end
        end
      end
    end
  end
end
