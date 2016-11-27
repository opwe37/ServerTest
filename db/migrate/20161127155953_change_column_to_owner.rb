class ChangeColumnToOwner < ActiveRecord::Migration
  def change
    change_column :owners, :phone_number, :string, :default => "0"
  end
end
