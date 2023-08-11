class Department < ApplicationRecord
  belongs_to :head, class_name: 'Teacher', optional: true
  has_many :courses
  has_many :teachers
  
end
