# frozen_string_literal: true

# Require the application system test case for system testing
require 'application_system_test_case'

# Define the RecipesTest class, inheriting from ApplicationSystemTestCase
class RecipesTest < ApplicationSystemTestCase
  # Setup method to run before each test
  setup do
    # Sign in as user one and set the @recipe instance variable
    sign_in users(:one)
    @recipe = recipes(:one)
  end

  # Test for visiting the index page
  test 'visiting the index' do
    # Visit the recipes URL and assert the presence of an h1 element with the text 'Recipes'
    visit recipes_url
    assert_selector 'h1', text: 'Recipes'
  end

  # Test for creating a recipe
  test 'should create recipe' do
    # Visit the recipes URL and click on the 'Add new recipe' link
    visit recipes_url
    click_on 'Add new recipe'

    # Fill in form fields with recipe data
    fill_in 'Title', with: @recipe.title
    find('.trix-content').set(@recipe.body)
    fill_in 'recipe[featured_image]', with: @recipe.featured_image, match: :prefer_exact
    fill_in 'Video url', with: @recipe.video_url

    # Click on 'Add an ingredient' twice and assert the presence of 'Ingredient' text
    click_on 'Add an ingredient'
    assert_text 'Ingredient'
    click_on 'Add an ingredient'
    assert_text 'Ingredient'

    # Iterate through cocooned items and fill in ingredient content for each
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

    # Click on 'Create Recipe', assert success message, and click on 'Back'
    click_on 'Create Recipe'
    assert_text 'Recipe was successfully created'
    click_on 'Back'
  end

  # Test for updating a recipe
  test 'should update Recipe' do
    # Visit the recipe URL and click on 'Edit this recipe'
    visit recipe_url(@recipe)
    click_on 'Edit this recipe', match: :first

    # Set new values for form fields
    find('.trix-content').set(@recipe.body)
    fill_in 'recipe[featured_image]', with: @recipe.featured_image, match: :prefer_exact
    fill_in 'Video url', with: @recipe.video_url

    # Click on 'Add an ingredient' twice and assert the presence of 'Ingredient' text
    click_on 'Add an ingredient'
    assert_text 'Ingredient'
    click_on 'Add an ingredient'
    assert_text 'Ingredient'

    # Iterate through cocooned items and fill in ingredient content for each
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

    # Click on 'Update Recipe', assert success message, and click on 'Back'
    click_on 'Update Recipe'
    assert_text 'Recipe was successfully updated'
    click_on 'Back'
  end

  # Test for destroying a recipe
  test 'should destroy Recipe' do
    # Visit the recipe URL, click on 'Delete this recipe', and accept the alert
    visit recipe_url(@recipe)
    click_on 'Delete this recipe', match: :first
    page.driver.browser.switch_to.alert.accept

    # Assert success message
    assert_text 'Recipe was successfully destroyed'
  end
end
