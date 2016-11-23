# service.rb

$LOAD_PATH << '../CLI' # require will search for files in this directory

require 'sinatra'
require 'digest'
require 'main.rb'

set :port, 80
main = Main.new
main.read_config

get '/create/:name' do |name|
  main.create_stack(name)
end

get '/delete/:name' do |name|
  main.delete_stack(name)
end

get '/test/:ip' do |ip|
  content_type 'application/json'
  result = main.check_if_drupal_is_up(ip)
  if result[0]
    status 200
    { '200' => result[1] }.to_json
  else
    status 400
    { '400' => "Drupal on #{ip} is down" }.to_json
  end
end
