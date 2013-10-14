module Siteleaf
  class Entity
  
    attr_reader :error

    def initialize(attributes = {})
      self.attributes = attributes
    end

    def self.all
      result = Client.get "#{self.endpoint}"
      result.map { |r| self.new(r) } if result
    end

    def self.find(id)
      result = Client.get "#{self.endpoint}/#{id}"
      self.new(result) if result
    end

    def self.create(attributes = {})
      self.new(attributes).save
    end

    def save
      if self.id
        result = Client.put "#{self.class.endpoint}/#{self.id}", self.attributes
      else
        result = Client.post "#{self.create_endpoint}", self.attributes
      end
      if result
        self.attributes = result
        return self
      end
    end

    def self.delete(id)
      Client.delete "#{self.endpoint}/#{id}"
    end

    def delete
      Client.delete "#{self.class.endpoint}/#{self.id}"
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

  end
end
