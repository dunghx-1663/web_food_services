class FoodCategory < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }
  
  # has_many :foods, dependent: :destroy, foreign_key: :food_category_id
end
