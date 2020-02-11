class RemoveArtistsFromTracks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tracks, :artists, :string
  end
end
