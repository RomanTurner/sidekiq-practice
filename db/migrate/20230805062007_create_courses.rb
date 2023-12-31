class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.belongs_to :department, null: false, foreign_key: true
      t.belongs_to :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
