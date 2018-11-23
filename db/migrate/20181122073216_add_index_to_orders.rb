class AddIndexToOrders < ActiveRecord::Migration[5.1]
  def change
    add_index :orders, [:customer_id, :employee_id]
  end
end
