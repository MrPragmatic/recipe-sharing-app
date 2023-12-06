# frozen_string_literal: true

# test/integration/recipe_flow_test.rb

require 'test_helper'

class RecipeFlowTest < ActionDispatch::IntegrationTest
  test 'get recipe index after registration' do
    get '/'

    # register through https
    https!

    get '/users/sign_in'
    assert_response :success

    post '/users/', params: { user: { email: 'lol@lol.com', password: 'NewEpicPassw0rd' } }
    follow_redirect!

    assert_equal '/', path
    assert_equal 'Welcome! You have signed up successfully.', flash[:notice]
  end

  test 'get user profile when signing in' do
    get '/'

    # login through https
    https!

    get '/users/sign_in'
    assert_response :success

    post '/users/', params: { user: { email: 'lol@lol.com', password: 'NewEpicPassw0rd' } }
    follow_redirect!

    get '/users_profile'
    assert_response :success
    assert_equal '/users_profile', path
    assert_select 'h1', 'User Profile'
  end
end
