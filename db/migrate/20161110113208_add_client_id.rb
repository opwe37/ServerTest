class AddClientId < ActiveRecord::Migration
  def change
    add_column :foodtrucks, :owner_id, :integer
  end
end
