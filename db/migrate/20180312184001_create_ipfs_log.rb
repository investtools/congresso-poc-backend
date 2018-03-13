class CreateIpfsLog < ActiveRecord::Migration[5.1]
  def change
    create_table :ipfs_logs do |t|
      t.datetime :date, null: false
      t.string :ipfs_meta_key, null: false
      t.string :ipfs_value, null: false
    end
  end
end
