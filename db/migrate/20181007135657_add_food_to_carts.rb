class AddFoodToCarts < ActiveRecord::Migration[5.1]
  def change
    add_reference :carts, :food, foreign_key: true
  end
end
