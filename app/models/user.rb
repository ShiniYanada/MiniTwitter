class User < ApplicationRecord
  validates :identifier, presence: true
  validates :email, presence: true
  validates :name, length: {maximum: 30}
  has_secure_password
  validates :password, presence: true, allow_nil: true, length: {minimum: 6}

  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'following_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :favorites
  has_many :fav_posts, through: :favorites, source: :post

  def to_param
    identifier
  end

  def follow(other_user)
    active_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    Post.where("user_id IN (?) OR user_id = ?", following_ids, id)
  end

  def favorite(post)
    favorites.create(post_id: post.id)
  end

  def unfavorite(post)
    favorites.find_by(post_id: post.id).destroy
  end

  def favorite?(post)
    fav_posts.include?(post)
  end 

end
