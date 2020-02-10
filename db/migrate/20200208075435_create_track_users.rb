class CreateTrackUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :track_users do |t|
      t.references :track, foreign_key: true
      t.references :user, foreign_key: true
      t.string :source

      t.timestamps
    end
  end
end
