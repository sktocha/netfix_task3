# frozen_string_literal: true

class WelcomeController < ApplicationController
  PERMITTED_MESSAGE_ATTRS = ::EmailMessage::ATTRS_CONF.keys.freeze

  get '/' do
    'Hello from sinatra!!!'
  end

  post '/contact_us' do
    @email_message = EmailMessage.new(message_params)
    if @email_message.valid?
      ::Services::SendContactUsEmail.call(@email_message)
      [201, {}, ['']]
    else
      [422, {'Content-Type' => 'application/json'}, @email_message.errors.to_json]
    end
  end

  def message_params
    attrs = (params[:message] || {}).slice(*PERMITTED_MESSAGE_ATTRS)
    attrs[:attachment_file] &&= attrs[:attachment_file][:tempfile]
    attrs
  end
end
