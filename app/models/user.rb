class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :area , length: { maximum: 100}
    validates :age, numericality: { greater_than_or_equal_to: 0, only_integer: true, less_than: 150 } , allow_blank: true
    # 複数の投稿を持つことができる
    has_many :microposts
    # フォロー/フォロワー
    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
    has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    # お気に入り
    has_many :favorites, dependent: :destroy
    has_many :favorite_microposts, through: :favorites, source: :micropost
    
    # 他のユーザーをフォローする
    def follow(other_user)
      following_relationships.find_or_create_by(followed_id: other_user.id)
    end

    # フォローしているユーザーをアンフォローする
    def unfollow(other_user)
      following_relationship = following_relationships.find_by(followed_id: other_user.id)
      following_relationship.destroy if following_relationship
    end

    # あるユーザーをフォローしているかどうか？
    def following?(other_user)
      following_users.include?(other_user)
    end
    
    # お気に入りに登録する
    def favorite(micropost)
      favorites.find_or_create_by(micropost_id: micropost.id)
    end
    # お気に入りを解除する 
    def unfavorite(micropost)
      f = favorites.find_by(micropost_id)
      f.destroy if f.present?
    end
    # お気に入りに登録しているかどうか
    def favorite?(micropost)
      favorites.include?(favorite_microposts)
    end
    
    # usersテーブルに追加したカラムの名前をmount_uploaderに指定
    mount_uploader :image, ImageUploader
    
    def feed_items
     Micropost.where(user_id: following_user_ids + [self.id])
    end
end
