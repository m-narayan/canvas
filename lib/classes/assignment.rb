class Assignment < Canvas
  attr_accessor :id, :name, :description, :due_at, :course_id, :assignment_url, :assignment_group_id, :group_category_id, :canvas_url, :muted, :lock_explanation, :allowed_extensions, :points_possible, :submission_types, :use_rubric_for_grading, :rubric_settings, :rubric
  
  def initialize(id, params)
    @id = id
    attrs = %w(id name description due_at course_id assignment_url assignment_group_id group_category_id canvas_url muted lock_explanation allowed_extensions points_possible submission_types use_rubric_for_grading rubric_settings rubric)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) unless attr == "id" }
  end
  
end

class Submission < Canvas
  attr_accessor :assignment_id, :assignment, :course, :attempt_number, :body, :grade, :grade_for_current_submission, :html_url, :preview_url, :raw_score, :submission_comments, :submission_type, :submitted_at, :url, :user_id, :user
end