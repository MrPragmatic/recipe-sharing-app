# frozen_string_literal: true

# Adding slug column to recipes for friendly urls
class AddSlugToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :slug, :string
    add_index :recipes, :slug, unique: true
  end
end
