class User < ActiveRecord::Base
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
