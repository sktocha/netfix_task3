# frozen_string_literal: true

FactoryBot.define do
  factory :email_message do
    trait :invalid do
      attachment_file { '' }
    end

    trait :valid do
      name { 'Test name' }
      email { 'test@gmail.com' }
      message { 'Test' * 15 }
      attachment_file do
        file = Tempfile.new
        file.close!
        file
      end
    end
  end
end
