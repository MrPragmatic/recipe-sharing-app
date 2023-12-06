# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'visiting the sign in / sign up page' do
    visit('/users/sign_in')

    assert_selector 'h2', text: 'Log in'
  end
end
