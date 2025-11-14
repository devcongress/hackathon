class RemoveUniquenessFromPeoplesChoiceVoteInFinalSubmissions < ActiveRecord::Migration[8.0]
  def change
    remove_index :hackathon_final_submissions, :peoples_choice_vote_id
    add_index :hackathon_final_submissions, :peoples_choice_vote_id
  end
end
