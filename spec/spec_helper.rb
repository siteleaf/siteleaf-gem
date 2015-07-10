require File.expand_path('../../bin/commands/commands.rb', __FILE__)
Dir['/bin/commands/execution/*.rb'].each { |file| require file }

# code for silencing outputs by functions
# RSpec.configure do |config|
#   original_stderr = $stderr
#   original_stdout = $stdout
#   config.before(:all) do
#     # Redirect stderr and stdout to NULL, Hence no prints or puts
#     $stderr = File.open(File::NULL, "w")
#     $stdout = File.open(File::NULL, "w")
#   end
# end
