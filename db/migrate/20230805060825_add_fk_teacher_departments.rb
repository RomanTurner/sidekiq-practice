class AddFkTeacherDepartments < ActiveRecord::Migration[7.0]
  def change
    add_reference :departments, :head, foreign_key: { to_table: :teachers }
    add_reference :teachers, :department, index: true, foreign_key: true
  end
end
