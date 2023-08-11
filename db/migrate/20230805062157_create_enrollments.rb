class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.belongs_to :student, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: true
      t.string :grade

      t.timestamps
    end
  end
end
