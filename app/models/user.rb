class User < ApplicationRecord
    has_secure_password validations: false

    has_many :posts
    has_many :comments

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true

end
  