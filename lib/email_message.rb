# frozen_string_literal: true

class EmailMessage
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  ATTRS_CONF = {
    name: {error: 'must be >= 3 and <= 250'},
    email: {error: 'wrong format'},
    message: {error: 'must be > 50'},
    attachment_file: {error: 'is not a file type'}
  }.freeze

  attr_accessor(*ATTRS_CONF.keys)

  def initialize(attrs = {})
    ATTRS_CONF.each { |attr, _conf| instance_variable_set(:"@#{attr}", attrs[attr]) }
  end

  def valid?
    ATTRS_CONF.all? { |attr, _conf| public_send(:"#{attr}_valid?") }
  end

  def errors
    ATTRS_CONF.keys.each_with_object({}) do |attr, obj|
      !public_send(:"#{attr}_valid?") && obj[attr] = ATTRS_CONF[attr][:error]
    end
  end

  def name_valid?
    (3..250).cover?(@name.to_s.size)
  end

  def email_valid?
    @email.to_s.match?(EMAIL_REGEXP)
  end

  def message_valid?
    @message.to_s.size >= 50
  end

  def attachment_file_valid?
    @attachment_file.nil? || @attachment_file.instance_of?(File) ||
      @attachment_file.instance_of?(Tempfile)
  end
end
