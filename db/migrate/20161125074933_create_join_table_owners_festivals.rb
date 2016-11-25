class CreateJoinTableOwnersFestivals < ActiveRecord::Migration
  def change
    create_join_table :owners, :festivals do |t|
      # t.index [:owner_id, :festival_id]
      # t.index [:festival_id, :owner_id]
    end
  end
end
