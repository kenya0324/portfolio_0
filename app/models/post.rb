class Post < ApplicationRecord
	attachment :post_image
	belongs_to :user
	belongs_to :category
	has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_many :comments, dependent: :destroy
    has_and_belongs_to_many :hashtags

    validates :post_image, presence: true
    validates :post_name, presence: true
    validates :post_content, presence: true

    def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end


end
