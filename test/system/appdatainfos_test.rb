require "application_system_test_case"

class AppdatainfosTest < ApplicationSystemTestCase
  setup do
    @appdatainfo = appdatainfos(:one)
  end

  test "visiting the index" do
    visit appdatainfos_url
    assert_selector "h1", text: "Appdatainfos"
  end

  test "creating a Appdatainfo" do
    visit appdatainfos_url
    click_on "New Appdatainfo"

    click_on "Create Appdatainfo"

    assert_text "Appdatainfo was successfully created"
    click_on "Back"
  end

  test "updating a Appdatainfo" do
    visit appdatainfos_url
    click_on "Edit", match: :first

    click_on "Update Appdatainfo"

    assert_text "Appdatainfo was successfully updated"
    click_on "Back"
  end

  test "destroying a Appdatainfo" do
    visit appdatainfos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Appdatainfo was successfully destroyed"
  end
end
