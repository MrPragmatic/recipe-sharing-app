# frozen_string_literal: true

# Require the test helper file
require 'test_helper'

# Define a test class for the UsersProfilesController using ActionDispatch::IntegrationTest
class UsersProfilesControllerTest < ActionDispatch::IntegrationTest
  # Include Devise test helpers for authentication
  include Devise::Test::IntegrationHelpers

  # Setup method to run before each test
  setup do
    # Assign instance variable for a user from the test fixtures and sign in
    @user = users(:one) # Replace with your fixture data
    sign_in @user
  end

  # Test to check if the show action can be accessed successfully
  test 'should get show' do
    get user_profile_path(@user)
    assert_response :success
  end

  # Test to check if the edit action can be accessed successfully
  test 'should get edit' do
    get edit_user_registration_path(@user)
    assert_response :success
  end

  # Test to check if the update action can be executed successfully
  test 'should get update' do
    patch user_registration_path(@user, format: :html), params:
      { user: { name: 'New Name', bio: 'New Bio', current_password: 'SuperPassword_934%' } }
    assert_redirected_to root_path
    @user.reload
    assert_equal 'New Name', @user.name
    assert_equal 'New Bio', @user.bio
  end

  # Test to check if the update action fails with invalid parameters (empty email)
  test 'should not update user with invalid params (inserting empty email) ' do
    sign_in @user
    patch user_registration_path(@user, format: :html), params:
      { user: { email: '', name: 'Gary', current_password: 'SuperPassword_934%' } }
    @user.reload
    assert_response :unprocessable_entity
    assert_equal 'Test User', @user.name
  end

  # Test to check if the destroy action can be executed successfully
  test 'should get destroy' do
    assert_difference('User.count', -1) do
      delete users_profile_path
    end

    assert_redirected_to root_path
  end
end
