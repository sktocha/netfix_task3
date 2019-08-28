# frozen_string_literal: true

require 'net/http'

class ApplicationController < Sinatra::Base
  CAPTCHA_API_URI = URI.parse('https://www.google.com/recaptcha/api/siteverify').freeze
  set :views, File.expand_path('../views', __dir__)
  set :root, File.expand_path('../../', __dir__)

  configure :production, :development do
    enable :logging
    file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  configure :development do
    register Sinatra::Reloader
  end

  def valid_captcha?(captcha)
    params = {secret: ENV['CAPTCHA_SECRET_KEY'], response: captcha}
    response = Net::HTTP.post_form(CAPTCHA_API_URI, params)
    JSON.parse(response.body)['success']
  end

end
