require 'spec_helper'
require 'rails_helper'

feature 'create seller' do
  scenario "can create seller" do
    visit'/sellers/new'
    expect(page).to have_content('Create Seller Account')

    fill_in 'seller[name]',:with=>'Rspec Test'
    fill_in 'seller[longitude]',:with=>'54.55'
    fill_in 'seller[latitude]', :with=>"45.55"
    fill_in 'seller[address]', :with=>"Aberdeen Uni"
    fill_in 'seller[password]', :with=>"123456"
    fill_in 'seller[password_confirmation]', :with=>"123456"
    click_button 'Create Account'

    expect(page).to have_content('Rspec Test')
    expect(page).to have_content('Longitude: 54.55')
    expect(page).to have_content('Latitude: 45.55')
    expect(page).to have_content('Address: Aberdeen Uni')
  end
end

feature 'can logout' do
  scenario 'log out seller' do
    visit'/sellers/new'
    expect(page).to have_content('Create Seller Account')

    fill_in 'seller[name]',:with=>'Rspec Test'
    fill_in 'seller[longitude]',:with=>'54.55'
    fill_in 'seller[latitude]', :with=>"45.55"
    fill_in 'seller[address]', :with=>"Aberdeen Uni"
    fill_in 'seller[password]', :with=>"123456"
    fill_in 'seller[password_confirmation]', :with=>"123456"
    click_button 'Create Account'

    expect(page).to have_content('Seller Logout')
    click_link 'Seller Logout'

    expect(page).to have_content('Seller Login')
  end
end