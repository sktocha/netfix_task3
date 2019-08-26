# frozen_string_literal: true

require './lib/email_message.rb'
require 'tempfile'

describe EmailMessage do
  context 'when correct values' do
    let!(:email_message) do
      file = Tempfile.new
      file.close!
      described_class.new(
        name: 'Test name',
        email: 'test@gmail.com',
        message: 'Test' * 15,
        attachment_file: file
      )
    end

    it 'name is valid' do
      expect(email_message.name_valid?).to be true
    end

    it 'email is valid' do
      expect(email_message.email_valid?).to be true
    end

    it 'message is valid' do
      expect(email_message.message_valid?).to be true
    end

    it 'attachment_file is valid' do
      expect(email_message.attachment_file_valid?).to be true
    end

    it 'all attrs are valid' do
      expect(email_message.valid?).to be true
    end

    it 'errors hash is empty' do
      expect(email_message.errors.empty?).to be true
    end
  end

  context 'when incorrect values' do
    let!(:email_message) { described_class.new(attachment_file: 'file') }

    it 'name is invalid' do
      expect(email_message.name_valid?).to be false
    end

    it 'email is invalid' do
      expect(email_message.email_valid?).to be false
    end

    it 'message is invalid' do
      expect(email_message.message_valid?).to be false
    end

    it 'attachment_file is invalid' do
      expect(email_message.attachment_file_valid?).to be false
    end

    it 'all attrs are invalid' do
      expect(email_message.valid?).to be false
    end

    it 'errors hash is not empty' do
      errors = {
        name: 'must be >= 3 and <= 250',
        email: 'wrong format',
        message: 'must be > 50',
        attachment_file: 'is not a file type'
      }
      expect(email_message.errors).to eq errors
    end
  end
end
