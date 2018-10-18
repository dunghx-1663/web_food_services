class AddFoodToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :food, foreign_key: true
  end
end
