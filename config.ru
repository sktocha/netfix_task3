# frozen_string_literal: true

require './config/environment'
require "./config/#{Sinatra::Base.environment}"

map('/') { run WelcomeController }
