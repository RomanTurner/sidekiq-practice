class CreateSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :submissions do |t|
      t.belongs_to :assignment, null: false, foreign_key: true
      t.belongs_to :student, null: false, foreign_key: true
      t.date :submitted_at
      t.string :file_path

      t.timestamps
    end
  end
end
