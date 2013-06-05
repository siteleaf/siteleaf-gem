module Siteleaf
  class User < Entity

    attr_accessor :email, :firstname, :lastname
    attr_reader :id, :created_at, :updated_at
    
  end
end