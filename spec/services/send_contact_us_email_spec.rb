# frozen_string_literal: true

describe Services::SendContactUsEmail do
  it 'send email correctly' do
    email_message = build(:email_message, :valid)
    file = Tempfile.new
    begin
      email_message.attachment_file = file
      expect(Mail::TestMailer.deliveries.size).to eq 0
      ::Services::SendContactUsEmail.call(email_message)
      expect(Mail::TestMailer.deliveries.size).to eq 1
      expect(Mail::TestMailer.deliveries.last.attachments.size).to eq 1
      body = Mail::TestMailer.deliveries.last.html_part.body.raw_source
      expect(body).to include email_message.email
    ensure
      file.close!
    end
  end
end
