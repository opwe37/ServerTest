class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      
      t.text :title
      t.text :content
      t.float :rating
      t.belongs_to :client
      t.belongs_to :foodtruck

      t.timestamps null: false
    end
  end
end
