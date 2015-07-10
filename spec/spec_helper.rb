require File.expand_path('../../bin/commands/commands.rb', __FILE__)
Dir['/bin/commands/execution/*.rb'].each { |file| require file }
