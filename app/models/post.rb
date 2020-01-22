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
  validates :post_name, length: { maximum: 38 }
  validates :post_content, presence: true
  validates :post_content, length: { maximum: 160 }

  def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

  def create_notification_like(current_user)
    notification=current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    notification.save if notification.valid?
  end

end
