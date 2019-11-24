class Answer < ActiveRecord::Base
  validates :content, length: { in: 8..500 }
  belongs_to :user
  belongs_to :question
  has_many :likes, class_name: "LikeAnswer"
end
