class LikeAnswer < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user

  def date
    self.created_at.to_date
  end
end
