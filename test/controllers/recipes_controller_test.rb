# frozen_string_literal: true

# Require the test helper file
require 'test_helper'

# Define a test class for the RecipesController using ActionDispatch::IntegrationTest
class RecipesControllerTest < ActionDispatch::IntegrationTest
  # Setup method to run before each test
  setup do
    # Sign in a user from the test fixtures
    sign_in users(:one)

    # Assign instance variables for a recipe and ingredients from the test fixtures
    @recipe = recipes(:one)
    @ingredient_one = ingredients(:one)
    @ingredient_two = ingredients(:two)
  end

  # Test to check if the index page can be accessed successfully
  test 'should get index' do
    get recipes_url
    assert_response :success
  end

  # Test to check if the new page can be accessed successfully
  test 'should get new' do
    get new_recipe_url
    assert_response :success
  end

  # Test to check if a recipe can be created successfully
  test 'should create recipe' do
    assert_difference('Recipe.count') do
      post recipes_url, params: { recipe: {
        user: @user,
        body: @recipe.body,
        featured_image: @recipe.featured_image,
        title: @recipe.title,
        video_url: @recipe.video_url,
        ingredients_attributes: [
          { content: @ingredient_one.content },
          { content: @ingredient_two.content }
        ]
      } }
    end

    assert_redirected_to recipe_url(Recipe.last)
  end

  # Test to check if a recipe can be shown successfully
  test 'should show recipe' do
    get recipe_url(@recipe)
    assert_response :success
  end

  # Test to check if the edit page can be accessed successfully
  test 'should get edit' do
    get edit_recipe_url(@recipe)
    assert_response :success
  end

  # Test to check if a recipe can be updated successfully
  test 'should update recipe' do
    patch recipe_url(@recipe), params: { recipe: {
      body: @recipe.body,
      featured_image: @recipe.featured_image,
      title: @recipe.title,
      video_url: @recipe.video_url,
      ingredients_attributes: [
        { content: @ingredient_one.content },
        { content: @ingredient_two.content }
      ]
    } }

    assert_redirected_to recipe_url(@recipe.title.parameterize)
  end

  # Test to check if a recipe can be destroyed successfully
  test 'should destroy recipe' do
    assert_difference('Recipe.count', -1) do
      delete recipe_url(@recipe)
    end

    assert_redirected_to root_path
  end
end
