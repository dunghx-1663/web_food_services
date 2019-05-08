class Cart < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :food, optional: true
  validates :quantity, presence: true, numericality: { greater_than: 0,  only_integer: true }


  scope :cart_amount_session, -> session_id {
    where(session_id: session_id)
  }

  scope :cart_order, -> user_id {
    select("quantity, food_id, total_money").where(user_id: user_id)
  }

  def Cart.total id
    carts = Cart.where(user_id: id)
    carts.map{|c| (c.food.price - c.food.discount.to_f/Settings.percentage * c.food.price) * c.quantity }.reduce(:+)
  end
end

