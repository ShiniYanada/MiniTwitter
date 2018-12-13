class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user
  has_one_attached :image
end
