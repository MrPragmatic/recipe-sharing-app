# frozen_string_literal: true

# Require the test helper file
require 'test_helper'

# Define a test class for the UserFlowTest using ActionDispatch::IntegrationTest
class UserFlowTest < ActionDispatch::IntegrationTest
  # Test to check if the recipe index can be accessed after registration
  test 'get recipe index after registration' do
    # Send a GET request to the root path
    get '/'

    # Set protocol to HTTPS
    https!

    # Send a GET request to the sign-in page
    get '/users/sign_in'
    assert_response :success

    # Send a POST request to register a user
    post '/users/', params: { user: { email: 'lol@lol.com', password: 'NewEpicPassw0rd' } }
    follow_redirect!

    # Assert that the path is root, and a success flash notice is set
    assert_equal '/', path
    assert_equal 'Welcome! You have signed up successfully.', flash[:notice]
  end

  # Test to check if the user profile can be accessed after signing in
  test 'get user profile when signing in' do
    # Send a GET request to the root path
    get '/'

    # Set protocol to HTTPS
    https!

    # Send a GET request to the sign-in page
    get '/users/sign_in'
    assert_response :success

    # Send a POST request to register a user
    post '/users/', params: { user: { email: 'lol@lol.com', password: 'NewEpicPassw0rd' } }
    follow_redirect!

    # Send a GET request to the user profile page
    get '/users_profile'
    assert_response :success

    # Assert that the path is /users_profile and the page contains an h1 element with 'User Profile'
    assert_equal '/users_profile', path
    assert_select 'h1', 'User Profile'
  end
end
