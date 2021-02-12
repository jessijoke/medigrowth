class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :condition
      t.integer :rating
      t.string :comments
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
