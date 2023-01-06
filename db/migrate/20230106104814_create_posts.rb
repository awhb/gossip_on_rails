class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :upvotes, default: 0
      t.references :user, null: false, type: :integer

      t.timestamps
    end
    add_foreign_key :posts, :users, column: :user_id, on_delete: :nullify
  end
end
