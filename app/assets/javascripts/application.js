// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require data-confirm-modal



$(document).ready(function(){
  $('textarea').autosize();
});



function buildHTML(post){
    var content = post.post_content ? `${post.post_content}` : "";
    var text = content.replace(/\n|\r\n|\r/g, '<br>');
    var image = post.post_image ? `<img src=${post.post_image}>` : " ";
    var html = `<div class="post">
		    	      <div class="post_index_user_name_image">
			    	    <%= attachment_image_tag post.user, :user_image, :fill,100,100, format: "jpeg", fallback: "no_image-c7305210e2d30bf8f19461ca05a151bba6413a44a35124f673246160efefdc5e.jpg", size: "50x50" %>
				        <%= link_to "#{post.user.name}" , users_user_path(post.user_id) %>
				      </div>
				      <div class="post_index_post_image">
					    <%= attachment_image_tag post, :post_image, :fill,100,100, format: "jpeg", fallback: "no_image-c7305210e2d30bf8f19461ca05a151bba6413a44a35124f673246160efefdc5e.jpg", size: "300x300" %>
					  </div>
				<div class="row">
				   <div class="col-6">
					  <div class="post_index_iine">
						<%= render 'posts', post: post %>
					  </div>
				   </div>
				   <div class="col-6">
					  <div class="post_index_post_category">
					  	<div id="post_index_category_link">
					  	 <%= link_to "/category/#{post.category.id}" do  %>
						 ${post.category.name}
						 <% end %>
						</div>
					  </div>
				   </div>
				</div>
					  <div class="post_index_post_name">
					     ${post.post_name}
					  </div>
					  <div class="post_index_content">
					  	 ${text}
					  </div>
			    <div class="row">
			       <div class="col-6">
			       	  <div class="post_index_url">
			       	  	<div id="post_url_link">
					      <a href= <%= post.url %>>shop</a>
					    </div>
					  </div>
				   </div>
				   <div class="col-6">
					  <div class="post_index_show">
					  	<div id="post_index_show_link">
						  <%= link_to '詳細', users_post_path(post), class:"btn-sm btn-light " %>
						</div>
					  </div>
				   </div>
			    </div>`;
    return html
  }