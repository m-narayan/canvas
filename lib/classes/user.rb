module CanvasREST

  class User < Canvas
    attr_accessor :id, :name, :sortable_name, :short_name, :login_id, :avatar_url,
    :primary_email, :locale, :last_login, :favorites,
    :groups, :courses, :conversations

    def self.test
      puts "inside user"
    end       

    def list_courses
      api_user_url = "https://192.168.1.40/api/v1/courses"
      response_json =JSON.parse(RestClient.get api_user_url, {:params => {:access_token => "DBzxyOO2xzYNwNbjgjEh4MCxtgYbKTfS4gRTWuDSskY3H1LnzHECJhygZN0RW73h"}})
      @response=response_json
    end                

    def initialize(id = nil)
      unless id.nil?
        @id = id
        @api_user_url = "#{@@api_root_url}/users/#{id}/profile"
      else
        @api_user_url = "#{@@api_root_url}/users/self/profile"
      end

      response_json = self.get_json(@api_user_url)
      attrs = %w(id name sortable_name short_name login_id avatar_url
       primary_email locale last_login favorites
       groups courses)
attrs.each { |attr| self.instance_variable_set("@#{attr}", response_json[attr]) unless attr == "id" and !(@id.nil?) }
@api_user_url = "#{@@api_root_url}/users/#{self.id}/profile"
end

def courses
  @api_course_url = "#{@@api_root_url}/courses"
  response_json = self.get_json(@api_course_url)
  @courses = []
  response_json.each do |course|
    @courses << Course.new(course["id"], course)
  end
  @courses
end

def communication_channels
  @communication_channels = []
  cc_url = "#{@@api_root_url}/users/#{user.id}/communication_channels"
  response_json = self.get_json(cc_url)
  response_json.each do |cc_json|
    @communication_channels << CommunicationChannel.new(cc_json)
  end
  @communication_channels
end

def groups
  @groups = []
  groups_url = "#{@@api_root_url}/users/self/groups"
  response_json = self.get_json(groups_url)
  response_json.each do |group_json|
    @groups << Group.new(group_json)
  end
  @groups
end

def conversations
  @conversations = []
  conversations_url = "#{@@api_root_url}/conversations"
  response_json = self.get_json(conversations_url)
  response_json.each do |conversation|
    @conversations << Conversation.new(conversation['id'], conversation)
  end
  @conversations
end

end

class CommunicationChannel < Canvas
  attr_accessor :id, :address, :type, :position, :user_id, :workflow_state
  
  def initialize(params)
    attrs = %w(id address type position user_id workflow_state)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) }
  end
  
end

end