class AddArtistsToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :artists, :string
  end
end
