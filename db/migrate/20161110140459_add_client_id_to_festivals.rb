class AddClientIdToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :client_id, :integer
  end
end
