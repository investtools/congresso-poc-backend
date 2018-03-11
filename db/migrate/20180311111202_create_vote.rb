class CreateVote < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :law_project_id, null: false
      t.boolean :vote, null: false
      t.string :comment, null: true
      t.string :address, null: false
      t.string :signed_message, null: false
    end
  end
end
