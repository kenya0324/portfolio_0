module Users::NotificationsHelper
	def notification_form(notification)
	  @visitor = notification.visitor
	  @comment = nil
	  @visited_post = notification.post_id
	  @visitor_comment = notification.comment_id
	  case notification.action
	    when "follow" then
	      tag.a(notification.visitor.name, href:users_user_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
	    when "like" then
	      tag.a(notification.visitor.name, href:users_user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_post_path(@visited_post), style:"font-weight: bold;")+"にwant!!しました"
	    when "comment" then
	      @comment = Comment.find(@visitor_comment)&.content
	      tag.a(@visitor.name, href:users_user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_post_path(@visited_post), style:"font-weight: bold;")+"にコメントしました"
	  end
	end

	def unchecked_notifications
      @notifications = current_user.passive_notifications.where(checked: false)
    end
end
