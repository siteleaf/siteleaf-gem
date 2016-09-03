module Siteleaf
  class Collection < Entity

    attr_accessor :title, :path, :permalink, :output, :site_id, :user_id, :metadata
    attr_reader :id, :directory, :created_at, :updated_at

    def create_endpoint
      ::File.join("sites", site_id, "collections")
    end

    def entity_endpoint
      ::File.join(create_endpoint, identifier)
    end

    def identifier
      path
    end

    def site
      Site.find(site_id)
    end

    def documents
      result = Client.get "#{entity_endpoint}/documents"
      result.map { |r| Document.new(r) } if result.parsed_response.is_a? Array
    end

    def files
      result = Client.get "#{entity_endpoint}/files"
      result.map { |r| File.new(r) } if result.parsed_response.is_a? Array
    end

    def output?
      output == true
    end

    def filename
      path
    end

  end
end