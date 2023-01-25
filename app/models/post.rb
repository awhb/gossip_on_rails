class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  
  validates :title, presence: true
  validates :content, presence: true
  validates :upvotes, presence: true
  validates :user_id, presence: true
  validates :categories, presence: true
end
