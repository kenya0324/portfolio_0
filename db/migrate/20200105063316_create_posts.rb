class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id,      null: false
      t.integer :genre_id,     null: false
      t.string  :post_image,   null: false
      t.text    :post_content, null: false

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
