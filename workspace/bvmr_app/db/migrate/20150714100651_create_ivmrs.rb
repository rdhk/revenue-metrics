class CreateIvmrs < ActiveRecord::Migration
  def change
    create_table :ivmrs do |t|
      t.float :ivmr_value
      t.timestamp :api_time

      t.timestamps null: false
    end
  end
end
