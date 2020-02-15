class AddEventToTracksUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :tracks_users, :event, foreign_key: true
  end
end
