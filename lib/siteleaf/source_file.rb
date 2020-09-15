module Siteleaf
  class SourceFile < Entity

    attr_accessor :file, :name, :site_id
    attr_reader :name, :url, :download_url, :type, :filesize, :sha, :created_at, :updated_at, :user_id

    def create_endpoint
      uri = URI.encode(identifier)
      uri = uri.gsub('[', '%5B').gsub(']', '%5D') # workaround for https://bugs.ruby-lang.org/issues/12235
      ::File.join('sites', site_id, 'source', uri)
    end

    def entity_endpoint
      create_endpoint
    end

    def identifier
      name
    end

    def to_file
      Client.get("#{entity_endpoint}?download")
    end

  end
end
