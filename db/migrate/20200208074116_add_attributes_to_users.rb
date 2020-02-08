class AddAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :genres, :string
    add_column :users, :spotify_user_id, :string
  end
end
