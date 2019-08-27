# frozen_string_literal: true

ENV['APP_ENV'] = 'test'
ENV['RACK_ENV'] = ENV['APP_ENV']

require 'rack/test'
require 'factory_bot'
require_relative '../config/environment.rb'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:each) do
    Mail::TestMailer.deliveries.clear
  end
end
