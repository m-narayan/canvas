class Group < Canvas
  attr_accessor :id, :name, :description, :is_public, :followed_by_user, :join_level, :members_count, :avatar_url, :context_type, :context_id, :role, :group_category_id, :memberships, :discussion_topics
  
  def initialize(params)
    attrs = %w(id name description is_public followed_by_user join_level
                members_count avatar_url context_type context_id role
                group_category_id)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) }
    
    api_group_discussion_topics_url = "#{@@api_root_url}/courses/#{self.id}/discussion_topics"
    dt_json = self.get_json(api_group_discussion_topics_url)
    @discussion_topics = []
    dt_json.each { |dt| @discussion_topics << DiscussionTopic.new(dt['id'], dt) }
  end
  
  def memberships
    @memberships = []
    @api_group_memberships_url = "#{@@api_root_url}/groups/#{self.id}/memberships"
    response_json = self.get_json(@api_group_memberships_url)
    response_json.each do |membership_json|
      @memberships << GroupMembership.new(membership_json)
    end
    @memberships
  end
  
end

class GroupMembership < Canvas
  attr_accessor :id, :group_id, :user_id, :workflow_state, :moderator
  
  def initialize(params)
    attrs = %w(id group_id user_id workflow_state moderator)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) }
  end
  
end