class RemoveClientIdFromFestival < ActiveRecord::Migration
  def change
    remove_column :festivals, :client_id, :integer
  end
end
