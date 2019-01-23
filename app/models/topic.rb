class Topic < ApplicationRecord
  belongs_to :user
  has_one :counter, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :minors, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :good_users, through: :goods, source: 'user', dependent: :destroy
  has_many :minor_users, through: :minors, source: 'user', dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: 'user', dependent: :destroy

  mount_uploader :image, TopicImageUploader

  scope :search, -> (keyword) {
    if keyword.present?
      words = keyword.to_s.gsub(/(?:[[:space:]%_])+/, " ").split(" ")
      title = (["topics.title LIKE ?"] * words.size).join(" AND ")
      description = (["topics.description LIKE ?"] * words.size).join(" AND ")
      name = (["users.name LIKE ?"] * words.size).join(" AND ")
      query = title + ' OR ' + description + ' OR ' + name

      where(
         query,
         *words.map{|w| "%#{w}%"},
         *words.map{|w| "%#{w}%"},
         *words.map{|w| "%#{w}%"}
       )
    end
  }
end
