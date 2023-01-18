class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :categories
  validates :title, presence: true
  validates :content, presence: true
  validates :upvotes, presence: true
  validates :user_id, presence: true
end
