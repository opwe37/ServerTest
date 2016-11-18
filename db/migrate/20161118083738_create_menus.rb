class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      
      t.string :name
      t.string :price
      t.binary :food_image
      t.belongs_to :foodtruck
      
      t.timestamps null: false
    end
  end
end
