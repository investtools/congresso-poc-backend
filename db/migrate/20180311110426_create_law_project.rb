class CreateLawProject < ActiveRecord::Migration[5.1]
  def change
    create_table :law_projects do |t|
      t.string :title, null: false
      t.text :text, null: false
    end
  end
end
