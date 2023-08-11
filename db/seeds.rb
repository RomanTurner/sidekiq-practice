puts "🧹 Starting to clean the database..."

Department.find_each do |department|
  department.update(head_id: nil)
end

Submission.delete_all
Assignment.delete_all
Enrollment.delete_all
Student.delete_all
Course.delete_all
Teacher.delete_all
Department.delete_all
puts "✅ Database cleaned!"

puts "🌱 Starting to seed..."

puts "🏢 Seeding departments..."
10.times do
  Department.create!(
    name: Faker::Educator.subject,
    location: Faker::Address.city
  )
end
puts "✅ Departments seeded!"

puts "👩‍🏫 Seeding teachers..."
50.times do
  department = Department.order("RANDOM()").first
  Teacher.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    department: department
  )
end
puts "✅ Teachers seeded!"

puts "👨‍💼 Assigning heads to departments..."
Department.find_each do |department|
  department.head = department.teachers.order("RANDOM()").first
  department.save!
end
puts "✅ Heads assigned!"

puts "📚 Seeding courses..."
100.times do
  department = Department.order("RANDOM()").first
  teacher = Teacher.order("RANDOM()").first
  Course.create!(
    name: Faker::Educator.course_name,
    code: Faker::Internet.unique.password,
    department: department,
    teacher: teacher
  )
end
puts "✅ Courses seeded!"

puts "👩‍🎓 Seeding students..."
200.times do
  Student.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email
  )
end
puts "✅ Students seeded!"

puts "📝 Seeding enrollments..."
400.times do
  student = Student.order("RANDOM()").first
  course = Course.order("RANDOM()").first
  grade = %w[A B C D F].sample
  Enrollment.create!(student: student, course: course, grade: grade)
end
puts "✅ Enrollments seeded!"

puts "📋 Seeding assignments..."
Course.find_each do |course|
  5.times do
    Assignment.create!(
      name: "#{course.name} Assignment #{Faker::Number.number(digits: 1)}",
      description: Faker::Lorem.paragraph,
      due_date: Faker::Date.forward(days: 30),
      course: course
    )
  end
end
puts "✅ Assignments seeded!"

puts "📥 Seeding submissions..."
Assignment.find_each do |assignment|
  assignment.course.students.each do |student|
    Submission.create!(
      assignment: assignment,
      student: student,
      file_path: Faker::File.file_name,
      submitted_at: Faker::Date.backward(days: 7)
    )
  end
end
puts "✅ Submissions seeded!"

puts "🎉 Seeding completed! Enjoy your new data. 🍻"
