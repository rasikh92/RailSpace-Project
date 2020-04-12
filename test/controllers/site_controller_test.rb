require 'test_helper'

class SiteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get site_index_url
    title = assigns(:title)
    assert_equal "Welcome to RailSpace!", title
    assert_response :success
    assert_template "index"
  end

  test "should get about" do
    get site_about_url
    title = assigns(:title)
    assert_equal "About RailSpace", title
    assert_response :success
    assert_template "about"
  end

  test "should get help" do
    get site_help_url
    title = assigns(:title)
    assert_equal "RailSpace Help", title
    assert_response :success
    assert_template "help"
  end

end
