class ChangeColumnToFoodtruck < ActiveRecord::Migration
  def change
    change_column :foodtrucks, :category, :integer
  end
end
