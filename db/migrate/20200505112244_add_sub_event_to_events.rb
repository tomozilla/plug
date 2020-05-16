class AddSubEventToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :sub_event, :boolean
  end
end
