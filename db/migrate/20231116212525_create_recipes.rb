class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :body
      t.string :video_url
      t.string :featured_image

      t.timestamps
    end
  end
end
