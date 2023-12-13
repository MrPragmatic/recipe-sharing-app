# frozen_string_literal: true

# Require the application system test case for system testing
require 'application_system_test_case'

# Define the UsersTest class, inheriting from ApplicationSystemTestCase
class UsersTest < ApplicationSystemTestCase
  # Test for visiting the sign-in/sign-up page
  test 'visiting the sign-in/sign-up page' do
    # Visit the sign-in URL and assert the presence of an h2 element with the text 'Log in'
    visit('/users/sign_in')
    assert_selector 'h2', text: 'Log in'
  end
end
