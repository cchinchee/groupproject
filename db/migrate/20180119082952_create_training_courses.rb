class CreateTrainingCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :training_courses do |t|
      t.string :title
      t.text :description
      t.references :affiliate, foreign_key: true
      t.timestamps
    end
  end
end
