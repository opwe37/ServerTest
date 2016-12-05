class ChangeColumnToFoodtruck < ActiveRecord::Migration
  def change
    change_column :foodtrucks, :open, :boolean, :default => false
  end
end
