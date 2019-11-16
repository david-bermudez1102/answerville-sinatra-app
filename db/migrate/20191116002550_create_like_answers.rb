class CreateLikeAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :like_answers do |t|
      t.integer :answer_id
      t.integer :user_id
      t.timestamps
    end
  end
end
