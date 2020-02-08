class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :genres
      t.string :image
      t.string :spotify_artist_id

      t.timestamps
    end
  end
end
