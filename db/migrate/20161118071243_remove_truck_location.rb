class RemoveTruckLocation < ActiveRecord::Migration
  def change
    drop_table :truck_locations
  end
end
