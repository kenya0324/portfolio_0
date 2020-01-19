class Post < ApplicationRecord
	attachment :post_image
	belongs_to :user
	belongs_to :category
	has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :hashtags
  has_many :notifications, dependent: :destroy
  validates :post_image, presence: true
  validates :post_name, presence: true
  validates :post_content, presence: true

  def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

  def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

end
