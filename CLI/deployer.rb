#!/usr/bin/env ruby
$LOAD_PATH << '.' # require will search for files in this directory
require 'thor'
require 'main'
require 'whirly'

##
# CLI class, inherited from THOR
class DrupalCLI < Thor
  def initialize(*args)
    super
    @main = Main.new
  end

  option :stackname, required: true
  option :config, required: false
  desc 'create', 'create AWS stack'
  ##
	# Calls the main class's create_stack function after it reads
	# the configuration from the config file
  def create
    credentials = read_config(options[:config])
    @main.create_stack(options[:stackname])
    print_status(@main.aws_client, 'CREATE_IN_PROGRESS', options[:stackname],
                 credentials)
  end

  option :stackname, required: true
  option :config, required: false
  desc 'delete', 'delete AWS stack'
  ##
	# Calls the main class's delete_stack function after it reads
	# the configuration from the config file
  def delete
    credentials = read_config(options[:config])
    @main.delete_stack(options[:stackname])
    print_status(@main.aws_client, 'DELETE_IN_PROGRESS', options[:stackname],
                 credentials)
  rescue Aws::CloudFormation::Errors::ValidationError
    puts "#{options[:stackname]} is deleted"
  end

  desc 'check', 'check if drupal is' \
  		' reachable on the defined host'
  option :host, required: true
  ##
	# Calls the main class's check_if_drupal_is_up function and
	# based on the status it prints if drupal is up or down
  def check
    status, body = @main.check_if_drupal_is_up(options[:host])
    if status
      puts 'Drupal is up!'
    else
      puts 'Drupal is down!'
    end
  end

  private
  ##
  # Function whic reads the configuration YAML file.
  def read_config(config_file)
    if config_file.nil?
      puts 'Config file not defined. Using default config.yml.'
      @main.read_config_file
    else
      @main.read_config_file(config_file)
    end
  end
end

##
# Prints the current status of the process with whirly progress bar
def print_status(client, condition, stackname, credentials)
  Whirly.configure spinner: 'dots'
  Whirly.start
  Whirly.status = whirly_status(condition, stackname)
  current_status = client.check_stack_status(credentials)
  while current_status == condition
    sleep(5)
    current_status = client.check_stack_status(credentials)
  end
  Whirly.stop
  puts client.check_stack_status(credentials)
end

##
# Decides if the process is deletation or
def whirly_status(condition, stackname)
  case condition
  when 'DELETE_IN_PROGRESS' then "Deleting #{stackname}"
  when 'CREATE_IN_PROGRESS' then "Creating #{stackname}"
  end
end

begin
  DrupalCLI.start(ARGV)
rescue Errno::ENOENT
  puts "No config file was found in #{__dir__}"
end
