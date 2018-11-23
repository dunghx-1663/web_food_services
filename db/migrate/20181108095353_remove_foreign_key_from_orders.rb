class RemoveForeignKeyFromOrders < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :orders, :users
  end
end
