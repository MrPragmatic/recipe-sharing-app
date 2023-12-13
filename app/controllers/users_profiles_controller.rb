# frozen_string_literal: true

# User profile controller to control CRUD operations
class UsersProfilesController < ApplicationController
  # Ensure user authentication for show, edit, update, and destroy actions
  before_action :authenticate_user!, only: %i[show edit update destroy]
  # Set the user before performing show, edit, update, or destroy actions
  before_action :set_user, only: %i[show edit update destroy]

  # Show the user's profile
  def show
    # Set the user to the currently authenticated user
    @user = current_user
  end

  # Render the edit page for the user's profile
  def edit
    # Set the user to the currently authenticated user
    @user = current_user
  end

  # Update the user's profile based on the provided parameters
  def update
    if @user.update(user_params)
      # Redirect to the user's profile with a success notice if the update is successful
      redirect_to user_profile_path(@user), notice: 'Profile was successfully updated.'
    else
      # Render the edit page again if the update is unsuccessful
      render :edit
    end
  end

  # Destroy the user along with the associated user profile
  def destroy
    @user.destroy

    # Redirect to the root path with a notice after successfully deleting the user account
    redirect_to root_path, notice: 'Your account has been deleted.'
  end

  private

  # Set the user based on the currently authenticated user
  def set_user
    @user = current_user
  end

  # Define the parameters allowed for user profile updates
  def user_params
    params.require(:user).permit(:name, :bio, :email, :password)
  end
end
