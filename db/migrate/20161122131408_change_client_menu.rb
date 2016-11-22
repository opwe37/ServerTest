class ChangeClientMenu < ActiveRecord::Migration
  def change
    remove_column :clients, :positionX
    remove_column :clients, :positionY
    
    add_column :clients, :lat, :float
    add_column :clients, :lng, :float
    
    change_column :menus, :food_image, :string
  end
end
