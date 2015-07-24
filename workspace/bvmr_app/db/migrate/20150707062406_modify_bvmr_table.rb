class ModifyBvmrTable < ActiveRecord::Migration
  def change
  	rename_column :bvmrs, :todays_date, :date
  	change_column :bvmrs, :date, :timestamp
  end
end
