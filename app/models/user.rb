class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]

         validates :name, presence: true, length: { in: 1..15 }
         validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
         validates :password, presence: true, length: { in: 8..32 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }

         has_one  :profile, dependent: :destroy
         has_many :topics, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :goods, dependent: :destroy
         has_many :minors, dependent: :destroy
         has_many :bookmarks, dependent: :destroy
         has_many :follows, dependent: :destroy
         has_many :bookmark_topics, through: :bookmarks, source: 'topic', dependent: :destroy

         def self.remove_same_email(user)
           where(email: user.email).where.not(id: user.id).delete_all
         end

         def self.resisteration_reset
           left_joins(:profile).where(profiles: {id: nil}).where("users.created_at > ?", 7.days.ago).delete_all
         end

         def self.get_bookmarks(user)
           user.bookmark_topics.order('created_at DESC').includes(:good_users, :minor_users, :bookmark_users)
         end

         def self.get_followings(user)
           joins(:follows).where(follows: {follower_id: user}).order('created_at DESC')
         end

         def self.get_posts(user)
           user.topics.order('created_at DESC')
         end

         def self.from_omniauth(auth)
           where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
             user.name = auth.info.nickname
             user.email = auth.info.email
             user.password = Devise.friendly_token[0,20]
           end
         end

         def update_with_password(params, *options)
          if encrypted_password.blank?            # encrypted_password属性が空の場合
            update_attributes(params, *options)   # パスワード入力なしにデータ更新
          else
            super
          end
        end
end
