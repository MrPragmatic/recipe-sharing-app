# frozen_string_literal: true

require 'application_system_test_case'

class RecipesTest < ApplicationSystemTestCase
  setup do
    sign_in users(:one)
    @recipe = recipes(:one)
  end

  test 'visiting the index' do
    visit recipes_url
    assert_selector 'h1', text: 'Recipes'
  end

  test 'should create recipe' do
    visit recipes_url
    click_on 'Add new recipe'

    fill_in 'Title', with: @recipe.title
    find('.trix-content').set(@recipe.body)
    fill_in 'recipe[featured_image]', with: @recipe.featured_image, match: :prefer_exact
    fill_in 'Video url', with: @recipe.video_url
    click_on 'Add an ingredient'
    assert_text 'Ingredient'
    click_on 'Add an ingredient'
    assert_text 'Ingredient'

    within '.cocooned-container' do
      all('.cocooned-item').each do |nested_fields|
        @recipe.ingredients.each do |ingredient|
          within(nested_fields) do
            ingredient_content_id = find('input[type="text"]')[:id]

            fill_in ingredient_content_id, with: ingredient.content
          end
        end
      end
    end

    click_on 'Create Recipe'

    assert_text 'Recipe was successfully created'
    click_on 'Back'
  end

  test 'should update Recipe' do
    visit recipe_url(@recipe)
    click_on 'Edit this recipe', match: :first

    find('.trix-content').set(@recipe.body)
    fill_in 'recipe[featured_image]', with: @recipe.featured_image, match: :prefer_exact
    fill_in 'Video url', with: @recipe.video_url
    click_on 'Add an ingredient'
    assert_text 'Ingredient'
    click_on 'Add an ingredient'
    assert_text 'Ingredient'

    within '.cocooned-container' do
      all('.cocooned-item').each do |nested_fields|
        @recipe.ingredients.each do |ingredient|
          within(nested_fields) do
            ingredient_content_id = find('input[type="text"]')[:id]

            fill_in ingredient_content_id, with: ingredient.content
          end
        end
      end
    end

    click_on 'Update Recipe'

    assert_text 'Recipe was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Recipe' do
    visit recipe_url(@recipe)
    click_on 'Delete this recipe', match: :first
    page.driver.browser.switch_to.alert.accept

    assert_text 'Recipe was successfully destroyed'
  end
end
