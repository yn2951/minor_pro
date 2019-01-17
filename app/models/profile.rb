class Profile < ApplicationRecord
  mount_uploader :image, UserImageUploader

  belongs_to :user
end
