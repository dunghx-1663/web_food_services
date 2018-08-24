class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :address
      t.float :total_money
      t.integer :status

      t.timestamps
    end
  end
end
