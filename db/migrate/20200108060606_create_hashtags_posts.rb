class CreateHashtagsPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags_posts  do |t|
      t.references :post,  foreign_key: true
      t.references :hashtag,  foreign_key: true
      t.timestamps
      t.index [:post_id, :hashtag_id], unique: true
    end
  end
end
