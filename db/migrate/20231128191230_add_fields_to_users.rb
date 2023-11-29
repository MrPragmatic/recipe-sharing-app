# frozen_string_literal: true

# Migration to add additional fields to the users table.
class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do
      add_column :users, :name, :string
      add_column :users, :bio, :text
    end
  end
end
