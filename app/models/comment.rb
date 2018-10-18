class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :food

  has_many :comments, foreign_key: "parent_id", dependent: :destroy

  validates :food, presence: true
  validates :user, presence: true

  scope :select_fields, (lambda do
    select :id, :content, :user_id, :food_id, :parent_id, :created_at
  end)

  scope :load_comment, ->food {where "food_id = ?", food.id}
  scope :except_reply, ->{where "parent_id IS ?", nil}
  scope :reply, ->comment {where "parent_id = ?", comment.id}
end
