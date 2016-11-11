class AddOwnerId < ActiveRecord::Migration
  def change
    add_column :festivals, :owner_id, :integer
  end
end
