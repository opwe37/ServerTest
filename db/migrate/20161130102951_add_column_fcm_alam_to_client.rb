class AddColumnFcmAlamToClient < ActiveRecord::Migration
  def change
    add_column :clients, :fcm_alam, :boolean, :default => false
  end
end
