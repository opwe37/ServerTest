class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      
      t.text :content
      t.belongs_to :review
      t.belongs_to :client
      
      t.timestamps null: false
    end
  end
end
