class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :album
      t.string :spotify_id

      t.timestamps
    end
  end
end
