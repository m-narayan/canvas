module CanvasREST
  class Course < Canvas
    attr_accessor :id, :sis_course_id, :name, :course_code, :account_id, :start_at, :end_at, :enrollments, :course_calendar, :syllabus_body_html, :folders, :assignments, :pages, :discussion_topics


    def initialize(id=nil, params=[])
      if id!=nil 
        @id = id
        attrs = %w(id sis_course_id name course_code account_id start_at
         end_at enrollments course_calendar syllabus_body_html
         folders pages)
attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) unless attr == "id" }
end
    #get_assignments; get_dt #Speed this up
    #get_dt
  end

  def get_course(id)
      @api_course_url = "#{@@api_root_url}/courses/#{id}"
      response_json = self.get_json(@api_course_url)
      Course.new(response_json["id"], response_json)
  end

  def create_course(account_id,sis_course_id,name,public_description)
    url = "#{@@api_root_url}/accounts/#{account_id}/courses"
    data = {"account_id"=>account_id,"course" => { "sis_course_id" => sis_course_id,"name" => name, "public_description" => public_description }}
    JSON.parse(RestClient.post url,data, "Authorization" => "Bearer #{@@oauth_token}") 
  end  

  def update_course(id,name,public_description)
    url = "#{@@api_root_url}/courses/#{id}"
    data = {"course" => { "name" => name, "public_description" => public_description }}
    JSON.parse(RestClient.put url,data, "Authorization" => "Bearer #{@@oauth_token}") 
  end  

  def delete_course(id)
    url = "#{@@api_root_url}/courses/#{id}"
    RestClient.delete url, "Authorization" => "Bearer #{@@oauth_token}" 
  end  
  
  def modules
    modules = []
    @api_module_url = "#{@@api_root_url}/courses/#{self.id}/modules"    
    modules_json = self.get_json(@api_module_url)
    @modules=[]
    modules_json.each do |modulep|
      @modules << Module.new(self.id, modulep) 
    end
    @modules    
  end

  def pages
    @pages = []
    @api_page_url = "#{@@api_root_url}/courses/#{self.id}/pages"    
    pages_json = self.get_json(@api_page_url)
    pages_json.each { |page_json| @pages << Page.new(page_json) }
    @pages
  end
  
  
  
  private
  def get_assignments
    api_course_assignments_url = "#{@@api_root_url}/courses/#{self.id}/assignments"
    @assignments = []
    begin
      assignments_json = self.get_json(api_course_assignments_url)
    rescue RestClient::Unauthorized => e
    else
      assignments_json.each do |assignment|
        @assignments << Assignment.new(assignment["id"], assignment)
      end
      @assignments
    end
  end
  
  private
  def get_dt
    api_course_discussion_topics_url = "#{@@api_root_url}/courses/#{self.id}/discussion_topics"
    dt_json = self.get_json(api_course_discussion_topics_url)
    @discussion_topics = []
    dt_json.each { |dt| @discussion_topics << DiscussionTopic.new(dt['id'], dt) }
    @discussion_topics
  end
  
end

class Section < Canvas
  attr_accessor :id, :name, :sis_section_id, :course_id, :nonxlist_course_id
end

class CanvasModule < Canvas
  attr_accessor :id, :position, :name, :unlock_at, :require_sequential_progress, :prerequisite_module_ids, :state, :completed_at, :module_items
end

class CanvasModuleItem < Canvas
  attr_accessor :id, :position, :title, :indent_level, :type, :html_url, :canvas_api_url, :completion_requirement
end

end