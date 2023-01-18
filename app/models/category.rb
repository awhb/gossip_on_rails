class Category < ApplicationRecord
  belongs_to :posts
  validates :name, presence: true
end
