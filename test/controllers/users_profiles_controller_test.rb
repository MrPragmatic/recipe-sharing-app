# frozen_string_literal: true

require 'test_helper'

class UsersProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one) # Replace with your fixture data
    sign_in @user
  end

  test 'should get show' do
    get user_profile_path(@user)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_registration_path(@user)
    assert_response :success
  end

  test 'should get update' do
    patch user_registration_path(@user, format: :html), params:
      { user: { name: 'New Name', bio: 'New Bio', current_password: 'SuperPassword_934%' } }
    assert_redirected_to root_path
    @user.reload
    assert_equal 'New Name', @user.name
    assert_equal 'New Bio', @user.bio
  end

  test 'should not update user with invalid params (inserting empty email) ' do
    sign_in @user
    patch user_registration_path(@user, format: :html), params:
      { user: { email: '', name: 'Gary', current_password: 'SuperPassword_934%' } }
    @user.reload
    assert_response :unprocessable_entity
    assert_equal 'Test User', @user.name
  end

  test 'should get destroy' do
    assert_difference('User.count', -1) do
      delete users_profile_path
    end

    assert_redirected_to root_path
  end
end
