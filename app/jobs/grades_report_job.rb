require "csv"
require "acidic_job"

class GradesReportJob 
  def perform
    CSV.open("grades_report.csv", "wb") do |csv|
      csv << %w[Course Student Grade]

      Course.all.each do |course|
        course.students.each do |student|
          grade = student.enrollments.find_by(course_id: course.id).grade
          csv << [
            course.name,
            "#{student.first_name} #{student.last_name}",
            grade
          ]
        end
      end
    end
  end
end
