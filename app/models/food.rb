class Food < ApplicationRecord
	validates :name,  presence: true, length: { maximum: 50 }
	validates :price, presence: true, length: { maximum: 8 }
	validates :description, presence: true
	# validates :rating_avg, presence: true
    belongs_to :food_category, optional: true

    mount_uploader :img_url, AvatarUploader
end
