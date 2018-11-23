class AddIndexEmployeeIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_index :orders, :employee_id
  end
end
