class ChangeColumnToComment < ActiveRecord::Migration
  def change
      remove_column :comments, :client_id, :integer
      add_column :comments, :owner_id, :integer
  end
end
