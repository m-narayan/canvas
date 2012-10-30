class DiscussionTopic < Canvas
  attr_accessor :id, :title, :message, :html_url, :posted_at, :last_reply_at, :require_initial_post, :discussion_subentry_count, :read_state, :unread_count, :assignment_id, :delayed_post_at, :locked, :creator_username, :topic_children, :root_topic_id, :podcast_url, :discussion_type, :attachments, :permissions
  
  def initialize(id, params)
    @id = id
    attrs = %w(id title message html_url posted_at last_reply_at require_initial_post discussion_subentry_count read_state unread_count assignment_id delayed_post_at locked creator_username topic_children root_topic_id podcast_url discussion_type attachments permissions)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) unless attr == "id" }
  end
  
end