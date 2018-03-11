class ChangeVoteField < ActiveRecord::Migration[5.1]
  def change
    remove_column :votes, :vote
    add_column :votes, :vote_choice, :boolean, null: false
  end
end
