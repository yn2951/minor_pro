class Profile < ApplicationRecord
  validates :introduce, length: {maximum: 50}

  mount_uploader :image, UserImageUploader

  belongs_to :user
end
