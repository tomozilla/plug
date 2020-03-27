class AddIndexOnSpotifyIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :spotify_id
  end
end
