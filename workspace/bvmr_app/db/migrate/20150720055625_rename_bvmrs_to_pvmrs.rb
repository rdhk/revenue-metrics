class RenameBvmrsToPvmrs < ActiveRecord::Migration
  def self.up
    rename_table :bvmrs, :pvmrs
  end

  def self.down
    rename_table :pvmrs, :bvmrs
  end
end
