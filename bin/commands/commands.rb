require_relative 'execution/configure'
require_relative 'execution/common'
require_relative 'execution/help'
require_relative 'execution/pull'
require_relative 'execution/push'
require_relative 'execution/publish'
require_relative 'execution/authenticate'

# Provides functions for each SiteLeaf Command-line statement
module Commands
  def self.sever_command
    if File.exist?('config.ru')
      port = ARGV[2] if %w(-p --port).include?(ARGV[1]) && ARGV[1]
      `rackup config.ru -p #{port || '9292'} >&2`
    else
      puts "No config found, run `siteleaf config yoursite.com`.\n"
    end
  end

  def self.config_command
    return unless Execution::Common.authenticated?
    if !(site = Siteleaf::Site.find_by_domain(ARGV[1])).nil?
      Execution::Config.config site
    else
      puts "No site found for `#{ARGV[1]}`, run `siteleaf new #{ARGV[1]}` to create it.\n"
    end
  end

  def self.new_command
    return unless Execution::Common.authenticated?
    if (site = Siteleaf::Site.create(title: ARGV[1], domain: ARGV[1])) && (!site.error)
      Execution::Common.configure_site(site)
    else
      puts "Could not create site `#{ARGV[1]}`.\n"
    end
  end

  def self.pull_command
    if ARGV[1] == 'theme'
      return unless Execution::Common.authenticated?
      site_id = Execution::Common.site_configured?
      return unless site_id
      Execution::Pull.get_theme_assets(site_id)
    else
      puts "`#{ARGV[0]}` command not found.\n"
    end
  end

  def self.push_command
    if ARGV[1] == 'theme'
      return unless Execution::Common.authenticated?
      site_id = Execution::Common.site_configured?
      return unless site_id
      Execution::Push.put_theme_assets(site_id)
    else
      puts "`#{ARGV[0]}` command not found.\n"
    end
  end

  def self.publish_command
    return unless Execution::Common.authenticated?
    quiet = %w(-q --quiet).include?(ARGV[1]) && ARGV[1]
    site_id = Execution::Common.site_configured?
    return unless site_id
    Execution::Publish.publish(site_id, quiet)
  end
end
