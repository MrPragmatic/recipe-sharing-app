# frozen_string_literal: true

require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = recipes(:one)
    @ingredient_one = ingredients(:one)
    @ingredient_two = ingredients(:two)
  end

  test 'should get index' do
    get recipes_url
    assert_response :success
  end

  test 'should get new' do
    get new_recipe_url
    assert_response :success
  end

  test 'should create recipe' do
    assert_difference('Recipe.count') do
      post recipes_url, params: { recipe: {
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

  test 'should show recipe' do
    get recipe_url(@recipe)
    assert_response :success
  end

  test 'should get edit' do
    get edit_recipe_url(@recipe)
    assert_response :success
  end

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

  test 'should destroy recipe' do
    assert_difference('Recipe.count', -1) do
      delete recipe_url(@recipe)
    end

    assert_redirected_to recipes_url
  end
end
