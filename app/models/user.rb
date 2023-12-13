# frozen_string_literal: true

# User method which sets up role levels and default new user role
class User < ApplicationRecord
  # Define an attribute accessor for the 'admin' attribute
  attr_accessor :admin

  # Define a has_many association with the Recipe class and set dependency for destruction
  has_many :recipes, dependent: :destroy

  # Include default devise modules for user authentication
  # Other available modules are: :confirmable, :lockable, :timeoutable, :trackable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Define an enum for the 'role' attribute with possible values: user, moderator, admin
  enum role: { user: 0, moderator: 1, admin: 2 }

  # Callback to set the default user role after initialization if it's a new record
  after_initialize :set_default_user_role, if: :new_record?

  # Method to set the default user role to :user
  def set_default_user_role
    self.role ||= :user
  end

  # Method to check if the user has an admin role
  def admin?
    admin == true
  end
end
