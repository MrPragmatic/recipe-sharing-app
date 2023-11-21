# frozen_string_literal: true

# This abstract class serves as the base for all application models, providing common functionality and behaviors.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
