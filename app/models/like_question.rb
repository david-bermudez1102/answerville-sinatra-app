class LikeQuestion < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  def date
    self.created_at.to_date
  end
end
