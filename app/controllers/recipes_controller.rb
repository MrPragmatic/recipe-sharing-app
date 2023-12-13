# frozen_string_literal: true

# This controller handles actions related to recipes.
class RecipesController < ApplicationController
  # Ensure user authentication for edit, update, and destroy actions
  before_action :authenticate_user!, only: %i[edit update destroy]
  # Set the recipe before performing show, edit, update, or destroy actions
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    # Retrieve all recipes for display
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    # Find and set the specific recipe based on the friendly ID
    @recipe = Recipe.friendly.find(params[:id])
  end

  # GET /recipes/new
  def new
    # Initialize a new recipe instance
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    # Authorize the recipe owner and find the specific recipe for editing
    authorize_recipe_owner(@recipe)
    @recipe = Recipe.friendly.find(params[:id])
  end

  # POST /recipes or /recipes.json
  def create
    # Create a new recipe, set the current user as the owner, and save the recipe
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      # Save the recipe and handle different response formats
      save_recipe(format)
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    # Find the specific recipe, authorize the recipe owner, and update the recipe
    @recipe = Recipe.friendly.find(params[:id])
    authorize_recipe_owner(@recipe)

    respond_to do |format|
      # Save the updated recipe and handle different response formats
      save_recipe_update(format)
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    # Find the specific recipe based on the friendly ID
    @recipe = Recipe.friendly.find(params[:id])

    # Check if the current user is authorized to destroy the recipe
    unless user_authorized_to_destroy?
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to recipe_path
      return
    end

    # Attempt to destroy the recipe, handle errors, and redirect accordingly
    destroy_recipe
  rescue StandardError
    Rails.logger.error('Error destroying recipe')
    redirect_to recipes_path, alert: 'Unexpected error when deleting the recipe.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    # Find and set the specific recipe based on the friendly ID
    @recipe = Recipe.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:title, :body, :video_url, :featured_image, :slug,
                                   ingredients_attributes: %i[id content destroy])
  end

  # Authorize the recipe owner based on user roles
  def authorize_recipe_owner(recipe)
    return if current_user && (current_user.admin? || current_user == recipe.user)

    redirect_to recipe_path, alert: 'You are not authorized to perform this action.'
  end

  # Save the recipe and handle different response formats
  def save_recipe(format)
    if @recipe.save
      format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
      format.json { render :show, status: :created, location: @recipe }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @recipe.errors, status: :unprocessable_entity }
    end
  end

  # Save the updated recipe and handle different response formats
  def save_recipe_update(format)
    if @recipe.save
      format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
      format.json { render :show, status: :created, location: @recipe }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @recipe.errors, status: :unprocessable_entity }
    end
  end

  # Check if the user is authorized to destroy the recipe
  def user_authorized_to_destroy?
    current_user && (current_user.admin? || current_user == @recipe.user)
  end

  # Destroy the recipe and redirect accordingly
  def destroy_recipe
    @recipe.destroy!
    redirect_to root_path, notice: 'Recipe was successfully destroyed.'
  end
end
