class CreateCategoryQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :category_questions do |t|
      t.integer :question_id
      t.integer :category_id
    end
  end
end
