class ModifyFoodtruck < ActiveRecord::Migration
  def change
    remove_column :foodtrucks, :positionX
    remove_column :foodtrucks, :positionY
    
    add_column :foodtrucks, :latitude, :float
    add_column :foodtrucks, :longitude, :float
  end
end
