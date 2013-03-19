require 'rest_client'
require 'json'

class Canvas
  attr_accessor :oauth_token, :courses

   
  def set_token(oauth_token = "tKmI8hGorLtmUk2xCNHilSipYPJ1oCJ367qHeEWA8PMjJtY6LZurLeNPCJKa65TS", api_root_url = "https://192.168.1.40/api/v1")
    @@oauth_token = oauth_token
    @@api_root_url = api_root_url
  end
  
  def get_json(url)
    JSON.parse(RestClient.get url, {:params => {:access_token => @@oauth_token}})
  end
  
  def user(id = nil)
    User.new(id)
  end
  
end

# Load classes
Dir[File.dirname(__FILE__) + "/classes/*.rb"].each { |file| require file }