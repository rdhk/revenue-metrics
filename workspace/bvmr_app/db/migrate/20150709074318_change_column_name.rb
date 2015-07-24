class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :bvmrs, :numpkgs, :num_packages
  end
end
