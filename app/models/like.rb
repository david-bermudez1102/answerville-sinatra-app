class Like < ActiveRecord::Base
  has_many :questions, class_name: 'LikeQuestion'
  has_many :answers, class_name: 'LikeAnswer'
end
