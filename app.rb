# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader' if development?

class NetfixTask3App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello from sinatra!!!'
  end
end
