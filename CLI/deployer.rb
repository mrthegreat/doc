# deployer.rb
$LOAD_PATH << '.' # require will search for files in this directory
require 'thor'
require 'main'

# CLI class, inherited from THOR
class DrupalCLI < Thor
  def initialize(*args)
    super
    @main = Main.new
  end

  option :stackname, required: true
  option :config, required: false
  desc 'create', 'create AWS stack'
  def create
    read_config_file(options[:config])
    @main.create_stack(options[:stackname])
  end

  option :stackname, required: true
  option :config, required: false
  desc 'delete', 'delete AWS stack'
  def delete
    read_config_file(options[:config])
    @main.delete_stack(options[:stackname])
  end

  desc 'check', 'check if drupal is' \
  		'reachable on the defined ip and port'
  option :server, required: true
  def check
    status, body = @main.check_if_drupal_is_up(options[:server])
    if status
      puts 'Drupal is up!'
      puts body
    else
      puts 'Drupal is down!'
    end
  end

  private

  def read_config_file(config_file)
    if config_file.nil?
      puts 'Config file not defined. Using default config.yml.'
      @main.read_config
    else
      @main.read_config(config_file)
    end
  end
end

DrupalCLI.start(ARGV)
