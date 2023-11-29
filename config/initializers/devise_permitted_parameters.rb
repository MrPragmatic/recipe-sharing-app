# frozen_string_literal: true

# config/initializers/devise_permitted_parameters.rb
# initializer to permit name and bio attributes when signing up as a new user
module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise_controller?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio])
  end
end

# Include the module directly in the initializer
unless defined?(DeviseController)
  Rails.application.config.to_prepare do
    Devise::RegistrationsController.include DevisePermittedParameters
  end
end
