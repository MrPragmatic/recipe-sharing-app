# frozen_string_literal: true

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  setup do
    @recipe = recipes(:one)
    @ingredient_one = ingredients(:one)
    @ingredient_two = ingredients(:two)
    @body = action_text_rich_texts(:one_content)
  end

  test 'Should not save without a recipe title' do
    recipe = Recipe.new(
      body: @recipe.body,
      featured_image: @recipe.featured_image,
      video_url: @recipe.video_url,
      ingredients_attributes: [
        { content: @ingredient_one.content },
        { content: @ingredient_two.content }
      ]
    )
    assert_not recipe.save, 'Recipe saved without a title'
  end

  test 'Should not save without a recipe body' do
    recipe = Recipe.new(
      featured_image: @recipe.featured_image,
      title: @recipe.title,
      video_url: @recipe.video_url,
      ingredients_attributes: [
        { content: @ingredient_one.content },
        { content: @ingredient_two.content }
      ]
    )
    assert_not recipe.save, 'Recipe saved without a recipe body'
  end

  test 'Should save without any video url' do
    recipe = Recipe.new(
      body: @recipe.body,
      featured_image: @recipe.featured_image,
      title: @recipe.title,
      ingredients_attributes: [
        { content: @ingredient_one.content },
        { content: @ingredient_two.content }
      ]
    )
    assert recipe.save, 'Recipe not saved without any video url'
  end

  test 'Should save video with valid video url' do
    recipe = Recipe.new(
      body: @recipe.body,
      featured_image: @recipe.featured_image,
      title: @recipe.title,
      video_url: @recipe.video_url,
      ingredients_attributes: [
        { content: @ingredient_one.content },
        { content: @ingredient_two.content }
      ]
    )
    assert recipe.save, 'Recipe not saved with valid video url'
  end

  test 'Should not save without featured image' do
    recipe = Recipe.new(
      body: @recipe.body,
      video_url: @recipe.video_url,
      title: @recipe.title,
      ingredients_attributes: [
        { content: @ingredient_one.content },
        { content: @ingredient_two.content }
      ]
    )
    assert_not recipe.save, 'Recipe saved without a featured image'
  end

  test 'Should not save without any ingredient' do
    recipe = Recipe.new(
      body: @recipe.body,
      featured_image: @recipe.featured_image,
      video_url: @recipe.video_url,
      title: @recipe.title)
    assert_not recipe.save, 'Recipe saved without any ingredient'
  end
end
