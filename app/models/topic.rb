class Topic < ApplicationRecord
  enum category: {movie: 0, music: 1, app: 2}

  belongs_to :user
  has_many :comments
  has_many :goods
  has_many :minors
  has_many :bookmarks
  has_many :good_users, through: :goods, source:'user'
  has_many :minor_users, through: :minors, source:'user'
  has_many :bookmark_users, through: :bookmarks, source:'user'

  mount_uploader :image, TopicImageUploader
end
