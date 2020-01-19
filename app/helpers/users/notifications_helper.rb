module Users::NotificationsHelper
	def notification_form(notification)
	  @visitor = notification.visitor
	  @comment = nil
	  visitor = link_to notification.visitor.name, users_user_path(@visitor), style:"font-weight: bold;"
	  your_post = link_to 'あなたの投稿', users_post_path(notification), style:"font-weight: bold;"
	  case notification.action
	    when "follow" then
	      tag.a(notification.visitor.name, href:users_user_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
	    when "like" then
	      tag.a(notification.visitor.name, href:users_user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_post_path(notification), style:"font-weight: bold;")+"にwant!!しました"
	    when "comment" then
	      @comment = Comment.find_by(id:@visitor.comment_id)&.content
	      "#{visitor}が#{your_post}にコメントしました"
	  end
	end
end
