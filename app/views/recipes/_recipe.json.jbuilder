json.extract! recipe, :id, :title, :body, :video_url, :featured_image, :ingredients, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
