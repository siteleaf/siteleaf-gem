require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Checking Bundler setup'
begin
  Bundler.setup
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
  puts 'Run `bundle install` to install missing gems'
end

desc 'Run Rspec'
begin
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  puts 'No Rspec available'
end
