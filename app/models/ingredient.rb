# frozen_string_literal: true

# This class represents an ingredient used in a recipe.
# It stores the ingredient's content and establishes a one-to-many relationship with the Recipe class.
class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :content, presence: true
end
