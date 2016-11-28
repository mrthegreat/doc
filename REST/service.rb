#!/usr/bin/env ruby

$LOAD_PATH << '../CLI' # require will search for files in this directory

require 'sinatra'
require 'main.rb'

set :port, 1337
main = Main.new
main.read_config_file
##
# Create stack with POST method and stackname parameter
post '/:name' do |name|
  main.create_stack(name)
end

##
# Delete stack with DELETE method and stackname parameter
delete '/:name' do |name|
  main.delete_stack(name)
end

##
# Checks if drupal is up on host, with GET method
get '/check/:host' do |host|
  content_type 'application/json'
  result = main.check_if_drupal_is_up(host)
  if result
    { :message => "Drupal on #{host} is up!" }.to_json
  else
    { :message => "Drupal on #{host} is down" }.to_json
  end
end
