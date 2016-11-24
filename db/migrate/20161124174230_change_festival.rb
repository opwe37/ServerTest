class ChangeFestival < ActiveRecord::Migration
  def change
    remove_column :festivals, :truck_num
    
    add_column :festivals, :limit_num_of_application, :integer
  end
end
