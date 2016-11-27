class CreateDb < ActiveRecord::Migration
  def change
    create_table :clients do |t|
    
      t.string :email
      t.string :password_digest
      t.string :nickName
      t.string :membershipGrade
      t.string :phone_number
      t.string :image
      t.float :lat
      t.float :lng
      t.string :token
      t.belongs_to :foodtruck
      
      t.timestamps null: false
    end
    
    create_table :festivals do |t|
      
      t.string :title
      t.string :place
      t.string :status
      t.date :start_date
      t.date :end_date
      t.date :applicant_start
      t.date :applicant_end
      t.integer :support_type
      t.integer :limit_num_of_application
      t.text :condition
      t.string :image
      t.belongs_to :client
      
      t.timestamps null: false
    end
    
    create_table :foodtrucks do |t|
      
      t.string :name
      t.integer :category
      t.string :tag
      t.float :rating
      t.boolean :open
      t.boolean :payment_card
      t.string :region
      t.string :image
      t.float :lat
      t.float :lng
      t.string :opentime
      t.string :closetime
      t.belongs_to :client
      t.belongs_to :owner
      
      t.timestamps null: false
    end
    
    create_table :menus do |t|
      
      t.string :name
      t.string :price
      t.string :image
      t.belongs_to :foodtruck
      
      t.timestamps null: false
    end
    
    create_table :owners do |t|
      
      t.string :email
      t.string :password_digest
      t.string :phone_number
      t.string :business_number
      
      t.timestamps null: false
    end
    
    create_table :reviews do |t|
      
      t.text :title
      t.text :content
      t.float :rating
      t.string :image
      t.belongs_to :client
      t.belongs_to :foodtruck
      
      t.timestamps null: false
    end
    
  end
end
