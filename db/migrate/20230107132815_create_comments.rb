class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :upvotes, default: 0
      t.references :user, null: false, type: :bigint
      t.references :post, null: false, type: :bigint

      t.timestamps
    end
    add_foreign_key :comments, :users, column: :user_id, on_delete: :nullify
    add_foreign_key :comments, :posts, column: :post_id, on_delete: :cascade
  end
end
