require 'test_helper'

class RoutesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get routes_index_url
    assert_response :success
  end

  test "should get show" do
    get routes_show_url
    assert_response :success
  end

  test "should get new" do
    get routes_new_url
    assert_response :success
  end

  test "should get create" do
    get routes_create_url
    assert_response :success
  end

  test "should get edit" do
    get routes_edit_url
    assert_response :success
  end

  test "should get update" do
    get routes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get routes_destroy_url
    assert_response :success
  end

  test "should get export" do
    get routes_export_url
    assert_response :success
  end

end
