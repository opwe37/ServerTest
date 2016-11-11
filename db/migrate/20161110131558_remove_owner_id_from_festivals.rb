class RemoveOwnerIdFromFestivals < ActiveRecord::Migration
  def change
    remove_column :festivals, :owner_id
  end
end
