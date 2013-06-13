module Siteleaf
  class Post < Page

    attr_accessor :taxonomy
    
    def self.all
      result = Client.get "#{self.endpoint}"
      result.map { |r| self.new(r) } if result
    end
    
    def self.find(id)
      result = Client.get "#{self.endpoint}/#{id}"
      self.new(result) if result
    end
    
    def create_endpoint
      "pages/#{self.parent_id}/posts"
    end
    
    def parent
      Page.find(self.parent_id)
    end
    
  end
end