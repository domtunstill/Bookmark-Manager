require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
require_relative './setup_test_database'

ENV['ENVIRONMENT'] = 'test'

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end
end

RSpec.configure do |config|
  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
end

SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start do
  add_filter "database_connection_setup.rb"
end

# require our Sinatra app file
require File.join(File.dirname(__FILE__), '..', 'app.rb')

# tell Capybara about our app class
Capybara.app = BookmarkManager
