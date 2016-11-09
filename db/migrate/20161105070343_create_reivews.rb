class CreateReivews < ActiveRecord::Migration
  def change
    create_table :reivews do |t|
      
      t.text :title
      t.text :content
      t.float :rating
      t.integer :client_id
      t.integer :foodtruck_id

      t.timestamps null: false
    end
  end
end
