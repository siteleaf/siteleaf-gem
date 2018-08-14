module Siteleaf
  class Site < Entity

    attr_accessor :title, :domain, :timezone, :metadata, :defaults
    attr_reader :id, :user_id, :created_at, :updated_at

    def self.find_by_domain(domain)
      results = Client.get self.endpoint
      result = results.find {|d| d['domain'] == domain }
      self.new(result) if result
    end

    def self.import(attrs)
      result = Client.post "import", attrs
      Job.new(id: result["job_id"]) if result
    end

    def source_files(dir = '.', opts = {})
      result = Client.get ::File.join(entity_endpoint, "source", dir), opts
      result.map { |r| SourceFile.new(r.merge('site_id' => id)) } if result.is_a? Array
    end

    def pages
      result = Client.get "#{entity_endpoint}/pages"
      result.map { |r| Page.new(r) } if result.is_a? Array
    end

    def collections
      result = Client.get "#{entity_endpoint}/collections"
      result.map { |r| Collection.new(r) } if result.is_a? Array
    end

    def posts
      Collection.new(path: 'posts', site_id: id).documents
    end

    def uploads
      Collection.new(path: 'uploads', site_id: id).files
    end

    def publish
      result = Client.post "#{entity_endpoint}/publish", {}
      Job.new(id: result["job_id"]) if result
    end

    def full_url
      "http://#{domain}"
    end

    def filename
      "_config.yml"
    end

    def sha
      Siteleaf::GitHash.string(to_file)
    end

  end
end
