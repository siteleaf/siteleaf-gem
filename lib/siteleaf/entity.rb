module Siteleaf
  # Defines attributes of all elements in siteleaf
  class Entity
    attr_reader :error

    def initialize(attributes = {})
      self.attributes = attributes
    end

    def self.all
      result = Client.get "#{endpoint}"
      result.map { |r| new(r) } if result
    end

    def self.find(id)
      result = Client.get "#{endpoint}/#{id}"
      new(result) if result
    end

    def self.create(attributes = {})
      new(attributes).save
    end

    def save
      if id
        result = Client.put "#{self.class.endpoint}/#{id}", attributes
      else
        result = Client.post "#{create_endpoint}", attributes
      end
      return unless result
      self.attributes = result
      self
    end

    def self.delete(id)
      Client.delete "#{endpoint}/#{id}"
    end

    def delete
      Client.delete "#{self.class.endpoint}/#{id}"
    end

    def attributes
      Hash[instance_variables.map { |name| [name[1..-1], instance_variable_get(name)] }]
    end

    def attributes=(attributes = {})
      attributes.each_pair { |k, v| instance_variable_set("@#{k}", v) }
    end

    def self.class_name
      name.split('::')[-1]
    end

    def self.endpoint
      "#{class_name.downcase}s"
    end

    def create_endpoint
      self.class.endpoint
    end
  end
end
