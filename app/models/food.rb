class Food < ApplicationRecord
    
	validates :name,  presence: true, length: { maximum: 50 }
	validates :price, presence: true, length: { maximum: 8 }
	validates :description, presence: true
	# validates :rating_avg, presence: true
    belongs_to :food_category, optional: true
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :order_details, dependent: :destroy
    has_many :carts, dependent: :destroy
    
    delegate :name, to: :food_category, prefix: true, allow_nil: true
    mount_uploader :img_url, AvatarUploader
    
    scope :filter_food_category, -> food_category_id { where(food_category_id: food_category_id )}
    scope :food_search, -> text {where("name LIKE ?", "%#{text}%")}
    scope :newfood, -> {
      order("created_at DESC").limit(4)
    }

    scope :hotfood, -> {
      order("rating_avg DESC").limit(4)
    }

    scope :hotsale, -> {
      order("discount DESC").limit(4)
    }

    scope :order_by_time, ->{order updated_at: :desc}
end
