class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
    end

    create_table :categories_posts, id: false do |t|
      t.belongs_to :categories
      t.belongs_to :posts
    end
  end
end
