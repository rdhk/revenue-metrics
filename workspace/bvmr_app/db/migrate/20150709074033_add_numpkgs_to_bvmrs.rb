class AddNumpkgsToBvmrs < ActiveRecord::Migration
  def change
    add_column :bvmrs, :numpkgs, :integer
  end
end
