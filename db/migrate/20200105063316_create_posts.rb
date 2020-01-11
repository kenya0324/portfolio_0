class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id,      null: false
      t.integer :category_id,     null: false
      t.string  :post_image_id,   null: false
      t.string  :post_name,   null: false
      t.text    :post_content, null: false
      t.text    :url

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
