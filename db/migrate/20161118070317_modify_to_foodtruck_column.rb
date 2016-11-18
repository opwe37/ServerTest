class ModifyToFoodtruckColumn < ActiveRecord::Migration
  def change
    remove_column :foodtrucks, :latitude
    remove_column :foodtrucks, :longitude
    
    add_column :foodtrucks, :lat, :float
    add_column :foodtrucks, :lng, :float
  end
end
