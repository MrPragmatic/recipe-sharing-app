# frozen_string_literal: true

# This class represents an ingredient used in a recipe.
# It stores the ingredient's content and establishes a one-to-many relationship with the Recipe class.
class Ingredient < ApplicationRecord
  # Define a belongs_to association with the Recipe class, establishing a one-to-many relationship
  belongs_to :recipe

  # Validate the presence of the content attribute
  validates :content, presence: true
end
