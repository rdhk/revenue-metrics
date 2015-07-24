class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.timestamp :order_date
      t.float :sales

      t.timestamps null: false
    end
  end
end
