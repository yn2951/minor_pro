class User < ApplicationRecord
  validates :name, length: { in: 1..15 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { in: 8..32 }
  validates :password, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  has_many :topics

  has_secure_password
end
