require 'spec_helper'
require 'rails_helper'

feature 'add to cart' do
  scenario "can add item to cart" do
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

    fill_in 'product[substancename]', :with=>'Rspec Test Product'
    fill_in 'product[nonproprietaryname]', :with=>'Rspec Test Product'
    fill_in 'product[propname]', :with=>'Rspec Test Product'
    fill_in 'product[price]', :with=>'1234'
    fill_in 'product[producttype]', :with=>'Rspec Test Product'
    fill_in 'product[dosageform]', :with=>'Rspec Test Product'
    fill_in 'product[routename]', :with=>'Rspec Test Product'
    fill_in 'product[marketingcategory]', :with=>'Rspec Test Product'
    fill_in 'product[activenumerator]', :with=>'2'
    fill_in 'product[activeingredunit]', :with=>'MG'

    click_button 'Create Product'
    expect(page).to have_content('Rspec Test Product')

    click_link 'Seller Logout'

    visit'/users/new'
    expect(page).to have_content('Create Customer Account')

    fill_in 'user[name]',:with=>'Rspec Test'
    fill_in 'user[email]',:with=>'rspectest@test.com'
    fill_in 'user[password]', :with=>"123456"
    fill_in 'user[password_confirmation]', :with=>"123456"
    click_button 'Create Account'

    expect(page).to have_content('Rspec Test')
    expect(page).to have_content('Email: rspectest@test.com')
    expect(page).to have_content('User Logout')

    click_link 'Products'
    expect(page).to have_content('Rspec Test Product')
    click_on 'Rspec Test Product'

    expect(page).to have_content('Rspec Test Product')
    expect(page).to have_content('Product Seller')
    click_button 'Add to cart'

    expect(page).to have_content('My Cart')
    expect(page).to have_content('Quantity: 1')
    expect(page).to have_content('Rspec Test Product')
    expect(page).to have_content('Total: £1,234.00')

    expect(page).to have_content('Rspec Test Product')
    expect(page).to have_content('User Logout')
  end

  # Do multiple items
  scenario "Add multiple items to cart" do
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

    fill_in 'product[substancename]', :with=>'Rspec Test Product'
    fill_in 'product[nonproprietaryname]', :with=>'Rspec Test Product'
    fill_in 'product[propname]', :with=>'Rspec Test Product'
    fill_in 'product[price]', :with=>'55.34'
    fill_in 'product[producttype]', :with=>'Rspec Test Product'
    fill_in 'product[dosageform]', :with=>'Rspec Test Product'
    fill_in 'product[routename]', :with=>'Rspec Test Product'
    fill_in 'product[marketingcategory]', :with=>'Rspec Test Product'
    fill_in 'product[activenumerator]', :with=>'2'
    fill_in 'product[activeingredunit]', :with=>'MG'

    click_button 'Create Product'
    expect(page).to have_content('Rspec Test Product')
    expect(page).to have_content('Logged in as Rspec Test')
    click_link 'Logged in as Rspec Test'

    expect(page).to have_content('Add New Product')
    click_link 'Add New Product'

    fill_in 'product[substancename]', :with=>'miracle product'
    fill_in 'product[nonproprietaryname]', :with=>'miracle product'
    fill_in 'product[propname]', :with=>'miracle product'
    fill_in 'product[price]', :with=>'120.66'
    fill_in 'product[producttype]', :with=>'miracle product'
    fill_in 'product[dosageform]', :with=>'miracle product'
    fill_in 'product[routename]', :with=>'miracle product'
    fill_in 'product[marketingcategory]', :with=>'miracle product'
    fill_in 'product[activenumerator]', :with=>'5'
    fill_in 'product[activeingredunit]', :with=>'ML'

    click_button 'Create Product'
    expect(page).to have_content('miracle product')

    click_link 'Seller Logout'

    visit'/users/new'
    expect(page).to have_content('Create Customer Account')

    fill_in 'user[name]',:with=>'Rspec Test'
    fill_in 'user[email]',:with=>'rspectest@test.com'
    fill_in 'user[password]', :with=>"123456"
    fill_in 'user[password_confirmation]', :with=>"123456"
    click_button 'Create Account'

    expect(page).to have_content('Rspec Test')
    expect(page).to have_content('Email: rspectest@test.com')
    expect(page).to have_content('User Logout')

    click_link 'Products'
    expect(page).to have_content('Rspec Test Product')
    click_on 'Rspec Test Product'

    expect(page).to have_content('Rspec Test Product')
    expect(page).to have_content('Product Seller')
    click_button 'Add to cart'

    expect(page).to have_content('My Cart')
    expect(page).to have_content('Quantity: 1')
    expect(page).to have_content('Rspec Test Product')
    expect(page).to have_content('Total: £55.34')

    expect(page).to have_content('Keep Shopping')
    click_link 'Keep Shopping'

    expect(page).to have_content('miracle product')
    click_on 'miracle product'

    expect(page).to have_content('miracle product')
    click_button 'Add to cart'

    expect(page).to have_content('My Cart')
    click_link 'Keep Shopping'

    click_on 'miracle product'
    click_button 'Add to cart'

    expect(page).to have_content('My Cart')
    expect(page).to have_content('Quantity: 1')
    expect(page).to have_content('Rspec Test Product')
    expect(page).to have_content('Quantity: 2')
    expect(page).to have_content('miracle product')
    expect(page).to have_content('Total: £296.66')

    expect(page).to have_content('Rspec Test Product')
    expect(page).to have_content('User Logout')
  end
end
