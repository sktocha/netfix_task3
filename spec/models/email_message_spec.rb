# frozen_string_literal: true

describe EmailMessage do
  context 'when correct values' do
    let!(:email_message) { build(:email_message, :valid) }

    EmailMessage::ATTRS_CONF.each do |attr, _|
      it "#{attr} is valid" do
        expect(email_message.public_send(:"#{attr}_valid?")).to be true
      end
    end

    it 'all attrs are valid' do
      expect(email_message.valid?).to be true
    end

    it 'errors hash is empty' do
      expect(email_message.errors.empty?).to be true
    end
  end

  context 'when incorrect values' do
    let!(:email_message) { build(:email_message, :invalid) }

    EmailMessage::ATTRS_CONF.each do |attr, _|
      it "#{attr} is invalid" do
        expect(email_message.public_send(:"#{attr}_valid?")).to be false
      end
    end

    it 'all attrs are invalid' do
      expect(email_message.valid?).to be false
    end

    it 'errors hash is not empty' do
      errors = EmailMessage::ATTRS_CONF.map { |attr, conf| [attr, conf[:error]] }.to_h
      expect(email_message.errors).to eq errors
    end
  end
end
