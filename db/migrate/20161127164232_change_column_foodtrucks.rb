class ChangeColumnFoodtrucks < ActiveRecord::Migration
  def change
      remove_column :foodtrucks, :opentime, :time
      remove_column :foodtrucks, :closetime, :time
      
      add_column :foodtrucks, :opetime, :string
      add_column :foodtrucks, :closetime, :string
  end
end
