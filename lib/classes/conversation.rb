class Conversation < Canvas
  attr_accessor :id, :workflow_state, :last_message, :last_message_at, :message_count, :subscribed, :private, :starred, :properties, :audience, :audience_contexts, :avatar_url, :participants, :visible
  
  def initialize(id, params)
    @id = id
    attrs = %w(id workflow_state last_message last_message_at message_count subscribed private starred properties audience audience_contexts avatar_url participants visible)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) unless attr == "id" }
  end
  
end