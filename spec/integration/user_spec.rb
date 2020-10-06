require 'spec_helper'
require 'rails_helper'

feature 'create customer' do
  scenario "can create customer" do
    visit'/users/new'
    expect(page).to have_content('Create Customer Account')

    fill_in 'user[name]',:with=>'Rspec Test'
    fill_in 'user[email]',:with=>'rspectest@test.com'
    fill_in 'user[password]', :with=>"123456"
    fill_in 'user[password_confirmation]', :with=>"123456"
    click_button 'Create Account'

    expect(page).to have_content('Rspec Test')
    expect(page).to have_content('Email: rspectest@test.com')
  end
end

feature 'can logout' do
  scenario 'log out user' do
    visit'/users/new'
    expect(page).to have_content('Create Customer Account')

    fill_in 'user[name]',:with=>'Rspec Test'
    fill_in 'user[email]',:with=>'rspectest@test.com'
    fill_in 'user[password]', :with=>"123456"
    fill_in 'user[password_confirmation]', :with=>"123456"
    click_button 'Create Account'

    expect(page).to have_content('User Logout')
    click_link 'User Logout'

    expect(page).to have_content('Customer Login')
  end
end