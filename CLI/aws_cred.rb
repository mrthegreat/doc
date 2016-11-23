# aws_cred.rb

# Object which stores the AWS credential data
class AWSCred
  def initialize(credentials)
    @access_key = credentials[:access_key]
    @secret_access_key = credentials[:secret_access_key]
    @region = credentials[:region]
    @stack_name = credentials[:stack_name]
    @template = credentials[:template]
  end

  attr_reader :access_key

  attr_reader :secret_access_key

  attr_reader :region

  attr_reader :stack_name

  attr_reader :template
end
