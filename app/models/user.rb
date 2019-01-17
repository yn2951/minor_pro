class User < ApplicationRecord
  validates :name, presence: true, length: { in: 1..15 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { in: 8..32 }, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  has_many :profiles
  has_many :topics
  has_many :comments
  has_many :goods
  has_many :minors
  has_many :bookmarks
  has_many :good_topics, through: :goods, source:'topic'
  has_many :minor_topics, through: :minors, source:'topic'
  has_many :bookmark_topics, through: :bookmarks, source:'topic'

  has_secure_password
end
