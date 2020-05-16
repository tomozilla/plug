class CreateWorldCities < ActiveRecord::Migration[5.2]
  def change
    create_table :world_cities do |t|
      t.string :city
      t.string :city_ascii
      t.float :lat
      t.float :lng
      t.string :country
      t.string :iso2
      t.string :iso3
      t.string :admin_name
      t.string :capital
      t.string :population
      t.string :city_id

    end
  end
end
