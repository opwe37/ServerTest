class CreateTruckLocations < ActiveRecord::Migration
  def change
    create_table :truck_locations do |t|
      
      t.float :lat
      t.float :lng
      t.belongs_to :foodtrucks
      
      t.timestamps null: false
    end
  end
end
