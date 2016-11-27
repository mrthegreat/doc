# service.rb

$LOAD_PATH << '../CLI' # require will search for files in this directory

require 'sinatra'
require 'digest'
require 'main.rb'

set :port, 1337
main = Main.new
main.read_config

post '/:name' do |name|
  main.create_stack(name)
end

delete '/:name' do |name|
  main.delete_stack(name)
end

get '/check/:host' do |host|
  content_type 'application/json'
  result = main.check_if_drupal_is_up(host)
  if result
    { :message => "Drupal on #{host} is up!" }.to_json
  else
    { :message => "Drupal on #{host} is down" }.to_json
  end
end
