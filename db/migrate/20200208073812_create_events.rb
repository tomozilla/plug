class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.date :date
      t.string :venue
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
