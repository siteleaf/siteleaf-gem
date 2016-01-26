module Siteleaf
  class Entity
  
    attr_reader :error, :message

    def initialize(attributes = {})
      self.attributes = attributes
    end

    def self.all
      result = Client.get endpoint
      result.map { |r| new(r) } if result.is_a? Array
    end

    def self.find(identifier)
      result = Client.get "#{endpoint}/#{identifier}"
      new(result) if result
    end

    def self.create(attributes = {})
      new(attributes).save
    end
    
    def self.delete(identifier)
      Client.delete "#{endpoint}/#{identifier}"
    end

    def save
      if identifier
        result = Client.put entity_endpoint, attributes
      else
        result = Client.post create_endpoint, attributes
      end
      if result
        self.attributes = result
        return self
      end
    end

    def delete
      Client.delete entity_endpoint
    end

    def attributes
      Hash[self.instance_variables.map { |name| [name[1..-1], self.instance_variable_get(name)] }]
    end

    def attributes=(attributes = {})
      attributes.each_pair { |k, v| self.instance_variable_set("@#{k}", v) }
    end

    def self.class_name
      self.name.split('::')[-1]
    end

    def self.endpoint
      "#{self.class_name.downcase}s"
    end

    def create_endpoint
      self.class.endpoint
    end
    
    def entity_endpoint
      "#{self.class.endpoint}/#{identifier}"
    end
    
    def identifier
      id
    end

  end
end
