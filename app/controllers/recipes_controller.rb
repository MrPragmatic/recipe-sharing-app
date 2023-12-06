# frozen_string_literal: true

# This controller handles actions related to recipes.
class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update destroy]
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.friendly.find(params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    authorize_recipe_owner(@recipe)
    @recipe = Recipe.friendly.find(params[:id])
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      save_recipe(format)
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    @recipe = Recipe.friendly.find(params[:id])
    authorize_recipe_owner(@recipe)

    respond_to do |format|
      save_recipe_update(format)
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe = Recipe.friendly.find(params[:id])

    unless user_authorized_to_destroy?
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to recipe_path
      return
    end

    destroy_recipe
  rescue StandardError
    Rails.logger.error('Error destroying recipe')
    redirect_to recipes_path, alert: 'Unexpected error when deleting the recipe.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:title, :body, :video_url, :featured_image, :slug,
                                   ingredients_attributes: %i[id content destroy])
  end

  def authorize_recipe_owner(recipe)
    return if current_user && (current_user.admin? || current_user == recipe.user)

    redirect_to recipe_path, alert: 'You are not authorized to perform this action.'
  end

  def save_recipe(format)
    if @recipe.save
      format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
      format.json { render :show, status: :created, location: @recipe }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @recipe.errors, status: :unprocessable_entity }
    end
  end

  def save_recipe_update(format)
    if @recipe.save
      format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
      format.json { render :show, status: :created, location: @recipe }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @recipe.errors, status: :unprocessable_entity }
    end
  end

  def user_authorized_to_destroy?
    current_user && (current_user.admin? || current_user == @recipe.user)
  end

  def destroy_recipe
    @recipe.destroy!
    redirect_to root_path, notice: 'Recipe was successfully destroyed.'
  end
end
