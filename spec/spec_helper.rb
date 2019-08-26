# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'factory_bot'
require_relative '../config/environment.rb'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
