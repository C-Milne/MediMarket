require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "creating a Product" do
    visit products_url
    click_on "New Product"

    fill_in "Activeingredunit", with: @product.activeingredunit
    fill_in "Activenumerator", with: @product.activenumerator
    fill_in "Dosageform", with: @product.dosageform
    fill_in "Marketingcategory", with: @product.marketingcategory
    fill_in "Nonproprietaryname", with: @product.nonproprietaryname
    fill_in "Producttype", with: @product.producttype
    fill_in "Propname", with: @product.propname
    fill_in "Routename", with: @product.routename
    fill_in "Seller", with: @product.seller_id
    fill_in "Substancename", with: @product.substancename
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "updating a Product" do
    visit products_url
    click_on "Edit", match: :first

    fill_in "Activeingredunit", with: @product.activeingredunit
    fill_in "Activenumerator", with: @product.activenumerator
    fill_in "Dosageform", with: @product.dosageform
    fill_in "Marketingcategory", with: @product.marketingcategory
    fill_in "Nonproprietaryname", with: @product.nonproprietaryname
    fill_in "Producttype", with: @product.producttype
    fill_in "Propname", with: @product.propname
    fill_in "Routename", with: @product.routename
    fill_in "Seller", with: @product.seller_id
    fill_in "Substancename", with: @product.substancename
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "destroying a Product" do
    visit products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product was successfully destroyed"
  end
end
