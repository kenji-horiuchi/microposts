class Favorite < ActiveRecord::Base
    belongs_to :user
    belongs_to :micropost

    
    validates :user, presence: true
    validates :user_id, uniqueness: { scope: :micropost_id }
    validates :micropost, presence: true

end

