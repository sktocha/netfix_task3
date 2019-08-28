# frozen_string_literal: true

class ApplicationController < Sinatra::Base
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
    uri = URI.parse('https://www.google.com/recaptcha/api/siteverify')
    params = {secret: ENV['CAPTCHA_SECRET_KEY'], response: captcha}
    response = Net::HTTP.post_form(uri, params)
    JSON.parse(response.body)['success']
  end

end
