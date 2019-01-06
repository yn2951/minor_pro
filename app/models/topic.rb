class Topic < ApplicationRecord
  enum category: {movie: 0, music: 1, app: 2}

  belongs_to :user
  has_many :comments

  mount_uploader :image, TopicImageUploader
end
