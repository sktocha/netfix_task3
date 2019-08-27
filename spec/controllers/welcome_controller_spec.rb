# frozen_string_literal: true

describe WelcomeController do
  def app
    WelcomeController
  end

  context 'with index page' do
    it 'says hello' do
      get '/'
      expect(last_response.status).to eq 200
      expect(last_response.body).to include 'Contact us Form'
    end
  end

  context 'with contact_us action' do
    it 'send letter on correct message' do
      expect(Mail::TestMailer.deliveries.size).to eq 0
      file = Rack::Test::UploadedFile.new('spec/fixtures/file_to_upload.txt')
      params = {email_message: attributes_for(:email_message, :valid, attachment_file: file)}
      post '/contact_us', params
      expect(last_response.status).to eq 201
      expect(last_response.body).to eq ''
      expect(Mail::TestMailer.deliveries.size).to eq 1
    end

    it 'returns errors on incorrect message' do
      errors = EmailMessage::ATTRS_CONF.map { |attr, conf| [attr, conf[:error]] }.to_h
      params = {
        email_message: attributes_for(:email_message, :invalid, attachment_file: {tempfile: ''})
      }
      post '/contact_us', params
      expect(last_response.status).to eq 422
      expect(last_response.body).to eq errors.to_json
    end
  end
end
