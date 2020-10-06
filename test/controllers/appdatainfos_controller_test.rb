require 'test_helper'

class AppdatainfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appdatainfo = appdatainfos(:one)
  end

  test "should get index" do
    get appdatainfos_url
    assert_response :success
  end

  test "should get new" do
    get new_appdatainfo_url
    assert_response :success
  end

  test "should create appdatainfo" do
    assert_difference('Appdatainfo.count') do
      post appdatainfos_url, params: { appdatainfo: {  } }
    end

    assert_redirected_to appdatainfo_url(Appdatainfo.last)
  end

  test "should show appdatainfo" do
    get appdatainfo_url(@appdatainfo)
    assert_response :success
  end

  test "should get edit" do
    get edit_appdatainfo_url(@appdatainfo)
    assert_response :success
  end

  test "should update appdatainfo" do
    patch appdatainfo_url(@appdatainfo), params: { appdatainfo: {  } }
    assert_redirected_to appdatainfo_url(@appdatainfo)
  end

  test "should destroy appdatainfo" do
    assert_difference('Appdatainfo.count', -1) do
      delete appdatainfo_url(@appdatainfo)
    end

    assert_redirected_to appdatainfos_url
  end
end
