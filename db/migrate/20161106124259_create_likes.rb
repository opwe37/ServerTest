class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      
      t.belongs_to :client
      t.belongs_to :foodtruck

      t.timestamps null: false
    end
  end
end
