class AddForeignkey < ActiveRecord::Migration
  def change
    add_column :clients, :foodtruck_id, :integer
    add_column :foodtrucks, :client_id, :integer
  end
end
