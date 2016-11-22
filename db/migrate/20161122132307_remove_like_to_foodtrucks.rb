class RemoveLikeToFoodtrucks < ActiveRecord::Migration
  def change
    remove_column :foodtrucks, :like
  end
end
