# frozen_string_literal: true

# This migration creates the `ingredients` table in the database,
# which stores information about ingredients associated with recipes.
# It defines columns for the ingredient's content and establishes
# a one-to-many relationship with the `recipes` table.
class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.text :content
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
