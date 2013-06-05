module Siteleaf
  class User < Entity

    attr_accessor :id, :email, :firstname, :lastname, :created_at, :updated_at
    protected :id=, :created_at=, :updated_at=
    
  end
end