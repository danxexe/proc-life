require "rubygems"
require "bundler/setup"

Bundler.require

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/javascripts'
  environment.append_path 'assets/stylesheets'
  run environment
end

run Rack::ServerPages