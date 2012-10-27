class Page < Canvas
  attr_accessor :url, :title, :created_at, :updated_at, :body
  
  def initialize(params)    
    attrs = %w(url title created_at updated_at body)
    attrs.each { |attr| self.instance_variable_set("@#{attr}", params[attr]) }
  end
  
end