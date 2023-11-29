# frozen_string_literal: true

# User profile controller to control CRUD operations
class UsersProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show edit update destroy]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path(@user), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # Delete the current user with the associated user profile
    @user.destroy

    redirect_to root_path, notice: 'Your account has been deleted.'
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :bio, :email, :password)
  end
end
