class Post < ApplicationRecord
  belongs_to :user_id
  validates :title, presence: true
  validates :content, presence: true
  validates :upvotes, presence: true
  validates :user_id, presence: true
end
