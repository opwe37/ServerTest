class ChangeColumnFestival < ActiveRecord::Migration
  def change
    change_column :festivals, :period, :date
  end
end
