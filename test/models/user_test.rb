# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'default role should be user' do
    assert_equal 'user', @user.role
  end

  test 'admin? should return false by default' do
    assert_not @user.admin?
  end

  test 'admin? should return true when admin is set' do
    @user.admin = true
    assert @user.admin?
  end

  test 'should save with valid email and password' do
    assert @user.save
  end

  test 'should not save without an email' do
    @user.email = nil
    assert_not @user.save
  end
end
