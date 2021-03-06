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
    has_many :microposts
    
    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
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
end
