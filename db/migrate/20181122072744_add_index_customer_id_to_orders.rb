class AddIndexCustomerIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_index :orders, :customer_id
  end
end
