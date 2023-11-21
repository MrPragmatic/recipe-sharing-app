# frozen_string_literal: true

# This migration creates the `recipes` table in the database, which stores information about recipes in the application.
# It defines columns for the recipe's title, body, video URL, featured image, and timestamps.
class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :body
      t.string :video_url
      t.string :featured_image

      t.timestamps
    end
  end
end
