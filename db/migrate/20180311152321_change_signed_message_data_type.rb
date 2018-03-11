class ChangeSignedMessageDataType < ActiveRecord::Migration[5.1]
  def change
    change_column :votes, :signed_message, :text
  end
end
