class CreateJoinTableClientsFoodtrucks < ActiveRecord::Migration
  def change
    create_join_table :clients, :foodtrucks do |t|
      # t.index [:client_id, :foodtruck_id]
      # t.index [:foodtruck_id, :client_id]
    end
  end
end
