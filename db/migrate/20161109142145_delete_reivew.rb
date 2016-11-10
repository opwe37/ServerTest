class DeleteReivew < ActiveRecord::Migration
  def change
    drop_table :reivews
  end
end
