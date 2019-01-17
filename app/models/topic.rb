class Topic < ApplicationRecord
  enum category: {movie: 0, music: 1, app: 2}

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :minors, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :good_users, through: :goods, source:'user'
  has_many :minor_users, through: :minors, source:'user'
  has_many :bookmark_users, through: :bookmarks, source:'user'

  mount_uploader :image, TopicImageUploader
end
