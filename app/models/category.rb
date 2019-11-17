class Category < ActiveRecord::Base
  validates :name, length: { in: 4..20 }
  has_many :category_questions
  has_many :questions, through: :category_questions
end
