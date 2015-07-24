class CreateBvmr < ActiveRecord::Migration
  def change
    create_table :bvmrs do |t|
    	t.float :bvmr_value
      t.timestamp :api_time
    end
  end
end
