class AddDescriptionToFoodCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :food_categories, :description, :string
  end
end
