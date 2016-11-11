class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      
      t.string :email
      t.string :password_digest
      t.string :phone_number
      
      t.timestamps null: false
    end
  end
end
