class CreateAuthorization < ActiveRecord::Migration[5.1]
  def change
    create_table :authorizations do |t|
      t.string :cpf, null: false
      t.string :address, null: false
    end
  end
end
