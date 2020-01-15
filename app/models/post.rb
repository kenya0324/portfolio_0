class Post < ApplicationRecord
	attachment :post_image
	belongs_to :user
	belongs_to :category
	has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_many :comments, dependent: :destroy
    has_and_belongs_to_many :hashtags

    def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

    after_create do
    post = Post.find_by(id: self.id)
    hashtags  = self.post_content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
	    hashtags.uniq.map do |hashtag|
	      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
	      post.hashtags << tag
	    end
    end
end
