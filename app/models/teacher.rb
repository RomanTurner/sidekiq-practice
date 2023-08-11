class Teacher < ApplicationRecord
  belongs_to :department, foreign_key: 'department_id'
  has_many :courses
end
