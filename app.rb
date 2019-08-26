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

  PERMITTED_ATTRS = EmailMessage::ATTRS_CONF.keys.freeze

  def message_params
    params.slice(*PERMITTED_ATTRS)
  end

  post '/contact_us' do
    @email_message = EmailMessage.new(message_params)
    if @email_message.valid?
      Services::SendEmail.call(message)
      [201]
    else
      [422, @email_message.errors]
    end
  end
end

# Task #3
# Форма зворотнього зв'язку на сайті.

# Поля:

# reCAPTCHA https://www.google.com/recaptcha/intro/v3.html
# Після успішної валідації всі звернення шлемо на пошту. Файл має бути прикріплений до листа
