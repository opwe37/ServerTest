class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      
      t.string :title
      t.string :place
      t.string :period
      t.date :start_date
      t.date :end_date
      t.integer :truck_num
      t.integer :support_type
      t.text :condition
      t.binary :image
      
      t.belongs_to :client

      t.timestamps null: false
    end
  end
end
