class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :question_id
      t.integer :answer_id
      t.timestamps
    end
  end
end
