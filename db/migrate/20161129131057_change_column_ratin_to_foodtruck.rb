class ChangeColumnRatinToFoodtruck < ActiveRecord::Migration
  def change
    change_column :foodtrucks, :rating, :float, :default => 0
  end
end
