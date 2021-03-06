class Profile < ApplicationRecord
  validates :introduce, length: {maximum: 200}

  mount_uploader :image, UserImageUploader

  belongs_to :user
end
