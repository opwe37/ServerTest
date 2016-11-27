class AddColumnsToFootruck < ActiveRecord::Migration
  def change
    add_column :foodtrucks, :opentime, :time
    add_column :foodtrucks, :closetime, :time
  end
end
