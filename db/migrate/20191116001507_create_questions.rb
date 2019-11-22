class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :content
      t.boolean :answered
      t.integer :user_id
      t.timestamps
    end
  end
end
