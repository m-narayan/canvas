require 'rest_client'
require 'json'


  class Canvas
    attr_accessor :oauth_token, :courses

    def self.hello
      puts "hello"
    end

    def initialize())
      @@oauth_token = "DBzxyOO2xzYNwNbjgjEh4MCxtgYbKTfS4gRTWuDSskY3H1LnzHECJhygZN0RW73h"
      @@api_root_url = "https://192.168.1.40/"
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

