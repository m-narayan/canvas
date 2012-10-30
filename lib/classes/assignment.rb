class Assignment < Canvas
  attr_accessor :id, :name, :description, :due_at, :course_id, :assignment_url,
                :assignment_group_id, :group_category_id, :canvas_url, :muted,
                :lock_explanation, :allowed_extensions, :points_possible, 
                :submission_types, :use_rubric_for_grading, :rubric_settings, 
                :rubric, :submissions
  
  def initialize(id, params)
    @id = id
    attrs = %w(id name description due_at course_id assignment_url assignment_group_id 
              group_category_id canvas_url muted lock_explanation allowed_extensions 
              points_possible submission_types use_rubric_for_grading rubric_settings rubric)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) unless attr == "id" }
    
    @submissions = []
    submissions_json_url = "#{@@api_root_url}/courses/#{self.course_id}/assignments/#{self.id}/submissions"
    begin
      submissions_json = self.get_json(submissions_json_url)
    rescue RestClient::Unauthorized => e
    else
      submissions_json.each { |sub| @submissions << Submission.new(sub) }
    end
  end
  
end

# Untested so far, seems that my student account is not authorized to view submissions
class Submission < Canvas
  attr_accessor :assignment_id, :assignment, :course, :attempt_number, :body, 
                :grade, :grade_for_current_submission, :html_url, :preview_url, 
                :raw_score, :submission_comments, :submission_type, :submitted_at, 
                :url, :user_id, :user
  
  def initialize(params)
    attrs = %w(assignment_id assignment course attempt_number body grade 
               grade_for_current_submission html_url preview_url raw_score 
               submission_comments submission_type submitted_at url user_id user)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) }
  end
  
end