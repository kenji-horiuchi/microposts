class Micropost < ActiveRecord::Base
    belongs_to :user
    # お気に入り
    has_many :favorite
    has_many :favorite_users, through: :favorites, source: :user
    # CarrierWaveに画像と関連付けたモデルを伝える
    mount_uploader :picture, PictureUploader
    # validate独自のバリデーションを定義
    validate  :picture_size
    
    private
    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
