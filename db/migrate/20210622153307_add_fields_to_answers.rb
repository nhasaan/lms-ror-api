class AddFieldsToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :user_id, :integer
    add_column :answers, :lesson_id, :integer
  end
end
