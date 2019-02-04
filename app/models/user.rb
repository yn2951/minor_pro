class User < ApplicationRecord
  validates :name, presence: true, length: { in: 1..15 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { in: 8..32 }, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  has_one :profile, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :minors, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :bookmark_topics, through: :bookmarks, source: 'topic', dependent: :destroy

  has_secure_password

  def self.remove_same_email(user)
    where(email: user.email).where.not(id: user.id).delete_all
  end

  def self.resisteration_reset
    users = User.left_joins(:profile).where(profile: {id: nil}).delete_all
  end
end
