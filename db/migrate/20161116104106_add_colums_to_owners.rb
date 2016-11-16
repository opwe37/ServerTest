class AddColumsToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :business_number, :string
  end
end
