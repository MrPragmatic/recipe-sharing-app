# frozen_string_literal: true

# User method which sets up role levels and default new user role
class User < ApplicationRecord
  attr_accessor :admin

  has_many :recipes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: 0, moderator: 1, admin: 2 }
  after_initialize :set_default_user_role, if: :new_record?
  def set_default_user_role
    self.role ||= :user
  end

  def admin?
    admin == true
  end
end
