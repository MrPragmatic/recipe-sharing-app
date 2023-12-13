# frozen_string_literal: true

# This class represents a recipe in the application.
# It stores the recipe's title, body, video URL, featured image,
# and manages a collection of associated ingredients.
class Recipe < ApplicationRecord
  # Use the FriendlyId gem to generate slugs for the title
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Enable Action Text for rich text content in the 'body' attribute
  has_rich_text :body

  # Define a belongs_to association with the User class
  belongs_to :user

  # Define a has_many association with the Ingredient class and set dependency for destruction
  has_many :ingredients, dependent: :destroy

  # Allow nested attributes for ingredients and allow their destruction
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  # Validate the presence of the title attribute
  validates :title, presence: true

  # Validate the presence and minimum length of the body attribute
  validates :body, presence: true, length: { minimum: 50 }

  # Validate the format of the video_url attribute using a regex for YouTube URLs
  # regex by Lucas Caton
  # reference: https://www.lucascaton.com/2012/04/10/regex-to-match-youtube-urls-using-ruby
  validates :video_url,
            format: { with: %r{\A(?:https?://)?(?:www\.)?youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{10,})\z},
                      allow_blank: true }

  # Validate the presence and format of the featured_image attribute using a URI regex
  validates :featured_image, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[https])

  # Custom validation method to ensure the video_url has a valid format
  validate :validate_video_url

  # Custom validation method to ensure there is at least one ingredient
  validate :at_least_one_ingredient

  private

  # Validate the video_url attribute format using a custom method
  def validate_video_url
    return if video_url.blank?

    return if video_url.match?(%r{\A(?:https?://)?(?:www\.)?youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{10,})\z})

    errors.add(:video_url, 'has an invalid format')
  end

  # Custom validation method to ensure there is at least one ingredient
  def at_least_one_ingredient
    errors.add(:base, 'At least one ingredient is required') if ingredients.empty?
  end

  # Private method to check if the recipe belongs to a specific user
  def belongs_to_user?(user)
    return true if user.is_admin? || (self.user == user)

    false
  end
end
