class Conversation < Canvas
  attr_accessor :id, :workflow_state, :last_message, :last_message_at, :message_count, :subscribed, :private, :starred, :properties, :audience, :audience_contexts, :avatar_url, :participants, :visible
end