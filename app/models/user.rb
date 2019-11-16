class User < ActiveRecord::Base
  validates :name, length: { minimum: 6, message: "Enter a valid name." }
  validates :username, length: { minimum: 6 }, format: { with: /\A[a-zA-Z0-9]+\Z/, message: "Enter a valid username." }
  validates :email, format: {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Enter a valid email."}
  validates :password, length: { in: 6..20 }, format: { with: /\A[a-zA-Z0-9]+\Z/, message: "Enter a valid password." }

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
