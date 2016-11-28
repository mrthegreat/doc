require 'aws_client.rb'
require 'yaml'
require 'open-uri'
require 'aws_cred.rb'

##
# Class which contains main functionalities of the program
class Main
  def create_stack(stackname)
    @aws_client = AWSClient.new(@credentials, stackname)
    @aws_client.create_stack
  end

  def delete_stack(stackname)
    @aws_client = AWSClient.new(@credentials, stackname)
    @aws_client.delete_stack
  end

  def check_if_drupal_is_up(server)
    address = 'http://' + server + '/example'
    begin
      open(address) do |content|
        validate_response(content)
      end
    rescue OpenURI::HTTPError, Errno::ETIMEDOUT, SocketError
      false
    end
  end

  def read_config_file(config_file = File.join(__dir__, 'config.yml'))
    config = YAML.load_file(config_file)
    @credentials = AWSCred.new(access_key: config['aws']['accesskey'],
                               secret_access_key: config['aws']['secretkey'],
                               region: config['aws']['region'],
                               template: config['cloudformation']['template'])
  end

  attr_reader :aws_client

  private

  ##
  # Checks if the reponse is 200 OK and the response body contains 'Drupal'
  def validate_response(content)
    content.status[0] == '200' && content.read.include?('Drupal')
  end
end
