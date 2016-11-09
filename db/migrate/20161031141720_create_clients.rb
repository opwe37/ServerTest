class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :email
      t.string :password_digest
      t.string :nickName
      t.string :membershipGrade
      t.decimal :positionX
      t.decimal :positionY

      t.timestamps null: false
    end
  end
end