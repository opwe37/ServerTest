class ChangeColumnToFoodTrucks < ActiveRecord::Migration
  def change
    change_column :foodtrucks, :truck_image, :string
  end
end
