module Siteleaf
  class Meta < Entity

    attr_accessor :id, :key, :value, :page_id, :post_id
    protected :id=
    
    def create_endpoint
      if self.page_id
        "pages/#{self.page_id}/meta"
      elsif self.post_id
        "posts/#{self.post_id}/meta"
      end
    end
    
    def post
      Post.find(self.post_id) if self.post_id
    end
    
    def page
      Page.find(self.page_id) if self.page_id
    end
    
  end
end