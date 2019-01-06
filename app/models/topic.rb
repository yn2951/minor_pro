class Topic < ApplicationRecord
  enum category: {movie: 0, music: 1, app: 2}

  belongs_to :user

  mount_uploader :topic_image, TopicImageUploader
end
