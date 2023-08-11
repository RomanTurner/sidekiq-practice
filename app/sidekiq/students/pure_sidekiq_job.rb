class Student::PureSidekiqJob < AcidicJob::ActiveKiq
  include Sidekiq::Job

  def perform(student_id)
    @student = Student.find(student_id)

    with_acidic_workflow do |workflow|
      workflow.step :student_says_hello
    end
  end

  def student_says_hello
    p "Student #{@student.first_name} #{@student.last_name} says 'Hello!'"
  end
end
