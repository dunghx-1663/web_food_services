class AddFoodToOrderDetails < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_details, :food, foreign_key: true
  end
end
