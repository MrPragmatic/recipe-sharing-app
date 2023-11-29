# frozen_string_literal: true

# rubocop:disable Naming/MethodParameterName
# Create users with authentication using devise gem
class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  # rubocop:disable Rails/CreateTableWithTimestamps
  def change
    create_table :users do |t|
      add_authenticatable_fields(t)
      add_recoverable_fields(t)
      add_rememberable_fields(t)
      add_trackable_fields(t)
      add_role_field(t)
      add_timestamps(t)
    end

    add_indices
  end
  # rubocop:enable Rails/CreateTableWithTimestamps

  private

  def add_authenticatable_fields(t)
    t.string :email, null: false, default: ''
    t.string :encrypted_password, null: false, default: ''
  end

  def add_recoverable_fields(t)
    t.string :reset_password_token
    t.datetime :reset_password_sent_at
  end

  def add_rememberable_fields(t)
    t.datetime :remember_created_at
  end

  def add_trackable_fields(t)
    # Uncomment the lines below if needed
    # t.integer :sign_in_count, default: 0, null: false
    # t.datetime :current_sign_in_at
    # t.datetime :last_sign_in_at
    # t.string :current_sign_in_ip
    # t.string :last_sign_in_ip
  end

  def add_role_field(t)
    t.integer :role, default: 0
  end

  def add_timestamps(t)
    t.timestamps null: false
  end

  # rubocop:enable Naming/MethodParameterName
  def add_indices
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    # Uncomment the lines below if needed
    # add_index :users, :confirmation_token, unique: true
    # add_index :users, :unlock_token, unique: true
  end
end
