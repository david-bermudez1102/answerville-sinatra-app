class Answer < ActiveRecord::Base
  validates :content, length: { in: 15..500 }
  belongs_to :user
  belongs_to :question
  has_many :likes, class_name: "LikeAnswer"
end
