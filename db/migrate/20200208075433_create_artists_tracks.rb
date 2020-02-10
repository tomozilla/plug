class CreateArtistsTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :artists_tracks do |t|
      t.references :track, foreign_key: true
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
