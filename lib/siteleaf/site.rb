module Siteleaf
  class Site < Entity

    attr_accessor :title, :domain, :timezone, :metadata, :defaults
    attr_reader :id, :user_id, :created_at, :updated_at
    
    def self.find_by_domain(domain)
      results = Client.get self.endpoint
      result = results.find {|d| d['domain'] == domain }
      self.new(result) if result
    end
    
    def files
      result = Client.get "sites/#{self.id}/files"
      result.map { |r| File.new(r) } if result.is_a? Array
    end
    
    def uploads
      result = Client.get "sites/#{self.id}/uploads"
      result.map { |r| Upload.new(r) } if result.is_a? Array
    end
    
    def pages
      result = Client.get "sites/#{self.id}/pages"
      result.map { |r| Page.new(r) } if result.is_a? Array
    end
    
    def posts
      result = Client.get "sites/#{self.id}/posts"
      result.map { |r| Post.new(r) } if result.is_a? Array
    end
    
    def collections
      result = Client.get "sites/#{self.id}/collections"
      result.map { |r| Collection.new(r) } if result.is_a? Array
    end
    
    def publish
      result = Client.post "sites/#{self.id}/publish", {}
      Job.new(id: result.parsed_response["job_id"]) if result
    end
    
    def filename
      "_config.yml"
    end
    
    def sha
      Digest::SHA1.hexdigest(to_file)
    end
    
    def to_file
      config
    end
  
    protected
    
    def defaults_config
      defaults.map do |d|
        { 'scope' => {}, 'values' => d['values'] }.tap do |default|
          default['scope']['path'] = d['path'] if d['path']
          default['scope']['type'] = d['type'] if d['type']
        end
      end
    end
    
    def collections_config
      collections.each_with_object({'uploads' => {'output' => true}}) do |collection, hash|
        hash[collection.path] = collection.metadata || {}
        hash[collection.path]['title'] = collection.title
        hash[collection.path]['output'] = collection.output
        hash[collection.path]['permalink'] = collection.permalink unless collection.permalink.nil?
      end
    end
  
    def config
      attrs = metadata || {}
      attrs['title'] = title
      attrs['url'] = "http://#{domain}"
      attrs['timezone'] = timezone
      attrs['collections'] = collections_config
      attrs['defaults'] = defaults_config unless defaults.empty?
      attrs.empty? ? "---\n".freeze : attrs.to_yaml
    end
    
  end
end