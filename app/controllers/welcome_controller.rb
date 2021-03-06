# frozen_string_literal: true

class WelcomeController < ApplicationController
  PERMITTED_EMAIL_MESSAGE_ATTRS = ::EmailMessage::ATTRS_CONF.keys.freeze

  get '/' do
    slim :index
  end

  post '/contact_us' do
    if Sinatra::Base.test? || valid_captcha?(params['g-recaptcha-response'])
      @email_message = EmailMessage.new(email_message_params)
      if @email_message.valid?
        ::Services::SendContactUsEmail.call(@email_message)
        [201, {}, ['']]
      else
        [422, {'Content-Type' => 'application/json'}, @email_message.errors.to_json]
      end
    else
      [403, {}, ['']]
    end
  end

  def email_message_params
    attrs = (params[:email_message] || {}).slice(*PERMITTED_EMAIL_MESSAGE_ATTRS)
    if attrs[:attachment_file].is_a?(Hash)
      attrs[:attachment_file] = attrs[:attachment_file][:tempfile]
    end
    attrs
  end
end
