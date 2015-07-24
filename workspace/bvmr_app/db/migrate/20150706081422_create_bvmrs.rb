class CreateBvmrs < ActiveRecord::Migration
  def change
    create_table :bvmrs do |t|
      t.integer :total_value
      t.date :todays_date

      t.timestamps null: false
    end
  end
end
