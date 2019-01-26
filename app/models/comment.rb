class Comment < ApplicationRecord
  validates :text, presence: true, length: {in: 1..200}

  belongs_to :user
  belongs_to :topic
end
