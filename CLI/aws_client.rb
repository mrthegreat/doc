# aws_client.rb

require 'aws-sdk'

# This class implements the communication with
# AWS CloudFormation API
class AWSClient
  def initialize(credentials, stack_name)
    @client = Aws::CloudFormation::Client.new(
      access_key_id: credentials.access_key,
      secret_access_key: credentials.secret_access_key,
      region: credentials.region
    )
    @template = File.read(credentials.template)
    @stack_name = stack_name
  end

  def create_stack
    @client.create_stack(stack_name: @stack_name,
                         template_body: @template)
  end

  def delete_stack
    @client.delete_stack(stack_name: @stack_name)
  end

  def check_stack_status(credentials)
    Aws::CloudFormation::Stack.new(
      @stack_name,
      access_key_id: credentials.access_key,
      secret_access_key: credentials.secret_access_key,
      region: credentials.region
    ).stack_status
  end
end
