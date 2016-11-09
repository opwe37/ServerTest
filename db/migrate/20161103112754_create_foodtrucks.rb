class CreateFoodtrucks < ActiveRecord::Migration
  def change
    create_table :foodtrucks do |t|
      t.string :name
      t.string :category
      t.string :tag
      t.float :rating
      t.integer :like
      t.boolean :open
      t.boolean :payment_card
      t.string :region
      t.binary :truck_image
      t.decimal :positionX
      t.decimal :positionY
      
      t.timestamps null: false
    end
  end
end
