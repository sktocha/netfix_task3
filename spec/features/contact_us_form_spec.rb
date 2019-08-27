# frozen_string_literal: true

feature 'Contact us Form' do
  scenario 'check validation' do
    visit '/'
    expect(page).to have_text('Contact us Form')

    click_button 'Send'
    expect(page).to have_text('must be >= 3 and <= 250')
    expect(page).to have_text('must be > 50')
    expect(page).to have_text('wrong format')

    expect(page).to have_selector('fieldset:not([disabled])')
    fill_in 'Name', with: 'Test name'
    click_button 'Send'
    expect(page).not_to have_text('must be >= 3 and <= 250')
    expect(page).to have_text('must be > 50')
    expect(page).to have_text('wrong format')

    expect(page).to have_selector('fieldset:not([disabled])')
    fill_in 'Email', with: 'test@gmail.com'
    click_button 'Send'
    expect(page).not_to have_text('must be >= 3 and <= 250')
    expect(page).to have_text('must be > 50')
    expect(page).not_to have_text('wrong format')

    expect(page).to have_selector('fieldset:not([disabled])')
    fill_in 'Message', with: 'test' * 15
    click_button 'Send'
    expect(page).not_to have_text('must be >= 3 and <= 250')
    expect(page).not_to have_text('must be > 50')
    expect(page).not_to have_text('wrong format')

    expect(page).to have_text('Letter sent successfully')

    expect(Mail::TestMailer.deliveries.size).to eq 1

    click_button 'Send more'
    expect(page).not_to have_text('Letter sent successfully')
    expect(page).to have_text('Contact us Form')

    expect(page).not_to have_selector('.text-danger, .text-success, .is-valid, .is-invalid')
  end
end
