# frozen_string_literal: true

ENV['APP_ENV'] = 'test'
ENV['RACK_ENV'] = ENV['APP_ENV']

require 'rack/test'
require 'factory_bot'
require 'capybara/rspec'
require 'rack/handler/thin'
require_relative '../config/environment.rb'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods
  config.include Capybara::DSL

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:each) do
    Mail::TestMailer.deliveries.clear
  end
end

Capybara.register_server :thin do |app, port, host|
  Rack::Handler::Thin.run(app, Port: port, Host: host)
end

Capybara.configure do |config|
  config.app = WelcomeController
  config.default_driver = :selenium
  config.server = :thin
end
Thin::Logging.silent = true

def app
  WelcomeController
end
