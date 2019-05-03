class FoodCategory < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }
  validates :description, presence: true

  has_many :foods, dependent: :delete_all, foreign_key: :food_category_id
end
