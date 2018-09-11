class Picture < ApplicationRecord
  mount_uploader :image, AvatarUploader
  belongs_to :food, optional: true
  belongs_to :users, optional: true
  
end
