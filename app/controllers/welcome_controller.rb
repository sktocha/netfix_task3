# frozen_string_literal: true

class WelcomeController < ApplicationController
  PERMITTED_MESSAGE_ATTRS = ::EmailMessage::ATTRS_CONF.keys.freeze

  get '/' do
    'Hello from sinatra!!!'
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

  def message_params
    params.slice(*PERMITTED_MESSAGE_ATTRS)
  end
end
