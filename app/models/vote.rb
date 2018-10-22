class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :food
  after_update :update_food_rate

  private
  def update_food_rate
    food = Food.find(self.food_id)
    rate_count = food.votes.count
    sum_rate = food.votes.map{|v| v.rating}.reduce(:+)
    food.update_attributes(rating_avg: sum_rate / rate_count)
  end
end
