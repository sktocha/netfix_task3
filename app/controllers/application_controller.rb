# frozen_string_literal: true

class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../../views', __dir__)

  configure :production, :development do
    enable :logging
    file = File.new("#{settings.root}/../../log/#{settings.environment}.log", 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  configure :development do
    register Sinatra::Reloader
  end
end
