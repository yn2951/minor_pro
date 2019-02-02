class Topic < ApplicationRecord
  validates :title, presence: true, length: { in: 1..100 }
  validates :image, presence: true
  validates :description, presence: true, length: { in: 1..400 }

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

  enum category: {japanese: 0, english: 1, kpop: 2, category_else: 3}
  enum genre: {pops: 0, rock: 1, hiphop: 2, anime: 3, ballade: 4, folk: 5, lovesong: 6, jazz: 7, instrumental: 8, RB: 9, ganre_else: 10}

  scope :category_search, -> (value) {
    where(category: value) if value.present?
  }

  scope :genre_search, -> (value) {
    where(genre: value) if value.present?
  }

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
