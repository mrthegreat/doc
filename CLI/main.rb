require 'aws_client.rb'
require 'optparse'
require 'yaml'
require 'open-uri'
require 'whirly'
require 'aws_cred.rb'

# Class which contains main functionalities of the program
class Main
  def initialize(config)
    read_config(config)
  end

  def create_stack(stackname)
    aws_client = AWSClient.new(@credentials, stackname)
    aws_client.create_stack
    print_status(aws_client, 'CREATE_IN_PROGRESS', stackname)
  end

  def delete_stack(stackname)
    aws_client = AWSClient.new(@credentials, stackname)
    aws_client.delete_stack
    print_status(aws_client, 'DELETE_IN_PROGRESS', stackname)
  rescue Aws::CloudFormation::Errors::ValidationError
    puts "#{stackname} is deleted"
  end

  def check_if_drupal_is_up(server)
    address = 'http://' + server + '/example'
    begin
      open(address) do |content|
        return analyse_content(content)
      end
    rescue OpenURI::HTTPError, Errno::ETIMEDOUT, SocketError
      [false]
    end
  end

  def read_config(config_file = File.join(__dir__, 'config.yml'))
    config = YAML.load_file(config_file)
    @credentials = AWSCred.new(access_key: config['aws']['accesskey'],
                               secret_access_key: config['aws']['secretkey'],
                               region: config['aws']['region'],
                               template: config['cloudformation']['template'])
  end

  private

  def print_status(client, condition, stackname)
    Whirly.configure spinner: 'dots'
    Whirly.start
    Whirly.status = whirly_status(condition, stackname)
    current_status = client.check_stack_status(@credentials)
    while current_status == condition
      sleep(5)
      current_status = client.check_stack_status(@credentials)
    end
    Whirly.stop
    puts client.check_stack_status(@credentials)
  end

  def whirly_status(condition, stackname)
    return "Deleting #{stackname}" if condition == 'DELETE_IN_PROGRESS'
    return "Creating #{stackname}" if condition == 'CREATE_IN_PROGRESS'
  end

  def analyse_content(content)
    body = content.read
    to_return = [true, body.match(%r{<head>.*</head>}m)]
    return to_return if content.status[0] == '200' && body.include?('Drupal')
    [false]
  end
end
