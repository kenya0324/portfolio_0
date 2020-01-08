class RenameGenresToCategory < ActiveRecord::Migration[5.2]
  def change
  	rename_table :genres, :categories
  end
end
