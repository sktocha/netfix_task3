# frozen_string_literal: true

require 'slim'

module Services
  class SendContactUsEmail
    DEFAULT_OPTS = {
      body_part_header: {content_disposition: :inline},
      to: ENV['SMTP_U'],
      subject: 'Contact us form'
    }.freeze

    def self.call(email_message)
      @email_message = email_message
      body = Slim::Template.new('app/views/contact_us.slim').render(self)
      attachments =
        if email_message.attachment_file
          filename = File.basename(email_message.attachment_file)
          {filename => email_message.attachment_file.read}
        end
      opts = {attachments: attachments || {}, html_body: body}
      Pony.mail(DEFAULT_OPTS.merge(opts))
    end
  end
end
