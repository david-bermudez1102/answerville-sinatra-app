class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :category_questions
  has_many :categories, through: :category_questions
  has_many :likes, class_name: "LikeQuestion"
end
