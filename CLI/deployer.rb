#!/usr/bin/env ruby
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
    credentials = read_config_file(options[:config])
    @main.create_stack(options[:stackname])
    print_status(@main.aws_client, 'CREATE_IN_PROGRESS', options[:stackname],
                 credentials)
  end

  option :stackname, required: true
  option :config, required: false
  desc 'delete', 'delete AWS stack'
  def delete
    credentials = read_config_file(options[:config])
    @main.delete_stack(options[:stackname])
    print_status(@main.aws_client, 'DELETE_IN_PROGRESS', options[:stackname],
                 credentials)
  rescue Aws::CloudFormation::Errors::ValidationError
    puts "#{stackname} is deleted"
  end

  desc 'check', 'check if drupal is' \
  		' reachable on the defined ip and port'
  option :server, required: true
  def check
    status, body = @main.check_if_drupal_is_up(options[:server])
    if status
      puts 'Drupal is up!'
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
