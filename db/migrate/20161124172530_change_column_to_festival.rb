class ChangeColumnToFestival < ActiveRecord::Migration
  def change
    change_column :festivals, :image, :string
  end
end
