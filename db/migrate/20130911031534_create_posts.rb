class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.belongs_to :category
      t.belongs_to :user

      t.timestamps
    end
    add_index :posts, :category_id
    add_index :posts, :user_id
  end
end
