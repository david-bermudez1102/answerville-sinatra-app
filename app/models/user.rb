class User < ActiveRecord::Base
  validates :name, length: { minimum: 6 }
  validates :username, length: { minimum: 6 }, format: { with: /\A[a-zA-Z0-9-_.]+\Z/, message:"can't have any spaces or special characters, except for dashes or dots" }, uniqueness: true
  validates :email, format: {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: {message:"already belongs to an existing account"}
  validates :password, length: { in: 6..20 }, format: { without: /\s/ }

  has_secure_password

  has_many :questions
  has_many :answers
  has_many :like_questions
  has_many :like_answers

  has_many :follower_connections, foreign_key: :following_id, class_name: "Connection"
  has_many :followers, through: :follower_connections, source: :follower

  has_many :following_connections, foreign_key: :user_id, class_name: "Connection"
  has_many :following, through: :following_connections, source: :following
end
