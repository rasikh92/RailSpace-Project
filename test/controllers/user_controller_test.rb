require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_index_url
    title = assigns(:title)
    assert_equal "RailSpace User Hub", title
    assert_response :success
    assert_template "index"
  end

  test "should get register" do
    get user_register_url
    title = assigns(:title)
    assert_equal "Register", title
    assert_response :success
    assert_template "register"
  end

  test "should test form and all its tags" do
    get user_register_url
    assert_response :success
    #form
    assert_select "form",
                  :attributes => {:action => "user/register", :method => "post"}
    #input fields
    assert_select "input",
                  :attributes => {:name => "user[screen_name]",
                                  :type => "text",
                                  :size => User::SCREEN_NAME_SIZE,
                                  :minlength => User::SCREEN_NAME_MIN_LENGTH,
                                  :maxlength => User::SCREEN_NAME_MAX_LENGTH}
    assert_select "input",
                  :attributes => {:name => "user[email]",
                                  :type => "text",
                                  :size => User::EMAIL_SIZE,
                                  :maxlength => User::EMAIL_MAX_LENGTH}
    assert_select "input",
                  :attributes => {:name => "user[password]",
                                  :type => "password",
                                  :size => User::PASSWORD_SIZE,
                                  :minlength => User::PASSWORD_MIN_LENGTH,
                                  :maxlength => User::PASSWORD_MAX_LENGTH} 
    assert_select "input",
                  :attributes => {:type => "submit",
                                  :value => "Register!"}
  end

  test "should test a valid registration" do
    post user_register_url, params: {:user => {:screen_name => "new_screen_name",
                                     :email => "valid@example.com",
                                     :password => "long_enough_password"}}
    # Test assignment of user
    user = assigns(:user)
    assert_not_nil user

    # Test new user in the database
    new_user = User.find_by_screen_name_and_password(user.screen_name, user.password)
    assert_equal new_user, user

    # Test flash and redirect
    assert_equal "User <b>#{new_user.screen_name}</b> created!", flash[:notice]
    assert_redirected_to :action => "index"
  end

  test "should test an invalid registration" do
    post user_register_url, params: {:user => {:screen_name => "aa/noyes",
                                     :email => "invalid@example,com",
                                     :password => "sun"}}

    # Test display of error messages
    assert_select "div", :attributes => {:id => "errorExplanation",
                                        :class => "errorExplanation"}

    # Assert that each form field has at least one error displayed
    assert_select "li", :content => /Screen Name/
    assert_select "li", :content => /Email/
    assert_select "li", :content => /Password/

    # Test to see that the input fields are being wrapped with the correct div
    error_div = {:tag => "div", :attributes => {:class => "fieldWithErrors"}}

    assert_select "input[name='user[screen_name]'][value='aa/noyes']",
                           :parent => error_div
    assert_select "input[name='user[email]'][value='invalid@example,com']",
                           :parent => error_div
    assert_select "[name='user[password]']",
                           :parent => error_div
  end
end
