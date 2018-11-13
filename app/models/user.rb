class User < ApplicationRecord
  validates :identifier, presence: true
  validates :email, presence: true
  validates :name, length: {maximum: 30}
  has_secure_password
  validates :password, presence: true, allow_nil: true, length: {minimum: 6}

  has_many :posts, dependent: :destroy

  def to_param
    identifier
  end

end
