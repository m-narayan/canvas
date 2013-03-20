module CanvasREST
  class Module < Canvas    
    attr_accessor :id, :position, :name, :unlock_at, :require_sequential_progress, :prerequisite_module_ids, :state, :completed_at, :module_items
     
  def initialize(course_id, params)    
    @course_id = course_id
    attrs = %w(id position name unlock_at require_sequential_progress prerequisite_module_ids state completed_at module_items)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) }
  end
    
    # // the unique identifier for the module
  # id: 123,
  # // the state of the module: active, deleted
  # workflow_state: active,
# 
  # // the position of this module in the course (1-based)
  # position: 2,
# 
  # // the name of this module
  # name: "Imaginary Numbers and You",
# 
  # // (Optional) the date this module will unlock
  # unlock_at: "2012-12-31T06:00:00-06:00",
# 
  # // Whether module items must be unlocked in order
  # require_sequential_progress: true,
# 
  # // IDs of Modules that must be completed before this one is unlocked
  # prerequisite_module_ids: [121, 122],
# 
  # // The state of this Module for the calling user
  # // one of 'locked', 'unlocked', 'started', 'completed'
  # // (Optional; present only if the caller is a student)
  # state: 'started',
# 
  # // the date the calling user completed the module
  # // (Optional; present only if the caller is a student)
  # completed_at: nil
  
  
  def module_intems
    # /api/v1/courses/:course_id/modules/:module_id/items
    api_module_intems_url = "#{@@api_root_url}/courses/#{self.course_id}/modules/#{self.id}/items"    
    @module_items = []
    begin
      module_intems_json = self.get_json(api_module_intems_url)
    rescue RestClient::Unauthorized => e
    else
      module_intems_json.each do |module_intem|
        @module_items << ModuleItem.new(self.course_id, self.id, module_intem)
      end
      @module_items
    end  
  end
    
  end
  
  class ModuleItem < Canvas
    attr_accessor :id, :position, :title, :indent_level, :type, :html_url, :canvas_api_url, :completion_requirement
    
    def initialize(course_id, module_id, params) 
      @course_id = course_id   
      attrs = %w(id, position, title, indent_level, type, html_url, canvas_api_url, completion_requirement)
      attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) }
    end
  end
end