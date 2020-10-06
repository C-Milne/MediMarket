require 'spec_helper'
require 'rails_helper'

feature 'can add product' do
  scenario 'app product' do
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
    expect(page).to have_content('Add New Product')

    click_link 'Add New Product'
    expect(page).to have_content('Create Product')

    fill_in 'product[substancename]', :with=>'Rspec Test Product B'
    fill_in 'product[nonproprietaryname]', :with=>'Rspec Test Product B'
    fill_in 'product[propname]', :with=>'Rspec Test Product B'
    fill_in 'product[price]', :with=>'12.55'
    fill_in 'product[producttype]', :with=>'Rspec Test Product B'
    fill_in 'product[dosageform]', :with=>'Rspec Test Product B'
    fill_in 'product[routename]', :with=>'Rspec Test Product B'
    fill_in 'product[marketingcategory]', :with=>'Rspec Test Product B'
    fill_in 'product[activenumerator]', :with=>'2'
    fill_in 'product[activeingredunit]', :with=>'MG'
    click_button 'Create Product'

    expect(page).to have_content('Rspec Test Product B')

  end
end