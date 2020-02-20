class AddTokenToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :authentication_token, :string, limit: 30
    add_index :events, :authentication_token, unique: true
  end
end
