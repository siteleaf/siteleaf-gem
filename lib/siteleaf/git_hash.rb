module Siteleaf
  module GitHash
    # equivalent of `git hash-object file.txt`
    def self.file(filename)
      ::File.open(filename, 'r') do |f|
        Digest::SHA1.hexdigest("blob #{f.size}\0#{f.read}")
      end
    end
    
    def self.string(str)
      Digest::SHA1.hexdigest("blob #{str.bytesize}\0#{str}")
    end
  end
end