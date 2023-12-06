# frozen_string_literal: true

# AddUserToRecipes migration adds a user reference to the recipes table.
class AddUserToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipes, :user, foreign_key: true

    # Set a default user_id for existing records
    User.find_each do |user|
      Recipe.where(user: nil).update(user_id: user&.id)
    end

    # Change the column to be non-nullable
    change_column_null :recipes, :user_id, false
  end
end
