class AddColumnToFestival < ActiveRecord::Migration
  def change
    add_column :festivals, :applicant_start, :date
    add_column :festivals, :applicant_end, :date
    add_column :festivals, :status, :string
    
    remove_column :festivals, :period
  end
end
