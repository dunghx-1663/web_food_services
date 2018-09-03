class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.float :total_money

      t.timestamps
    end
  end
end
