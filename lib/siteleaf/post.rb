module Siteleaf
  class Post < Content

    attr_accessor :taxonomy
    
    def create_endpoint
      "sites/#{self.parent_id}/posts"
    end
    
  end
end