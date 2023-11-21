module Siteleaf
  class Role < Entity

    attr_accessor :kind, :user_id, :site_id
    attr_reader :id, :created_at, :updated_at

    def create_endpoint
      "sites/#{site_id}/roles"
    end
    
  end
end