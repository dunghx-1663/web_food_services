class AddFoodCategoryToFoods < ActiveRecord::Migration[5.1]
  def change
    add_reference :foods, :food_category, foreign_key: true
  end
end
