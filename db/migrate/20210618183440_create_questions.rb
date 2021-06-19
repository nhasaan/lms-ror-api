class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :a
      t.string :b
      t.string :c
      t.string :d
      t.string :correct
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
