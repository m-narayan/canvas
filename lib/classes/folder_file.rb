class CanvasFolder < Canvas
  attr_accessor :context_type, :context_id, :files_count, :position, :updated_at, :subfolders_url, :files_url, :full_name, :lock_at, :id, :subfolders_count, :name, :parent_folder_id, :created_at, :unlock_at, :hidden, :hidden_for_user, :locked, :locked_for_user
end

class CanvasFile < Canvas
  attr_accessor :size, :content_type, :url, :id, :display_name, :created_at, :updated_at, :unlock_at, :locked, :hidden, :lock_at, :locked_for_user, :hidden_for_user
end