class RenamePostHashtagsToHashtagsPost < ActiveRecord::Migration[5.2]
  def change
  	rename_table :post_hashtags, :hashtags_posts
  end
end
