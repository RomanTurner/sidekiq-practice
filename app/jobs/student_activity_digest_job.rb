class StudentActivityDigestJob < ApplicationJob

  def perform
    teacher_ids = Teacher.pluck(:id)
    with_acidic_workflow persisting: { collection: teacher_ids } do |workflow|
      workflow.step :process_digest, for_each: :collection
    end
  end

  private

  def process_digest(teacher_id)
    teacher = Teacher.find(teacher_id)
    new_enrollments =
      teacher
        .courses
        .joins(:enrollments)
        .where("enrollments.created_at > ?", 1.week.ago)
        .count
    assignments_submitted =
      teacher
        .courses
        .joins(:assignments)
        .where("assignments.created_at > ?", 1.week.ago)
        .count

    summary = {
      teacher_name: "#{teacher.first_name} #{teacher.last_name}",
      new_enrollments: new_enrollments,
      assignments_submitted: assignments_submitted
    }

    DigestMailer.weekly_summary(teacher.email, summary).deliver
  end
end
