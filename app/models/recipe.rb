# frozen_string_literal: true

# This class represents a recipe in the application.
# It stores the recipe's title, body, video URL, featured image,
# and manages a collection of associated ingredients.
class Recipe < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :body
  belongs_to :user

  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 50 }
  validates :video_url,
            # regex by Lucas Caton: https://www.lucascaton.com/2012/04/10/regex-to-match-youtube-urls-using-ruby
            format: { with: %r{\A(?:https?://)?(?:www\.)?youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{10,})\z},
                      allow_blank: true }
  validates :featured_image, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[https])

  validate :validate_video_url
  validate :at_least_one_ingredient

  private

  def validate_video_url
    return if video_url.blank?

    return if video_url.match?(%r{\A(?:https?://)?(?:www\.)?youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{10,})\z})

    errors.add(:video_url, 'has an invalid format')
  end

  def at_least_one_ingredient
    errors.add(:base, 'At least one ingredient is required') if ingredients.empty?
  end

  def belongs_to_user?(user)
    return true if user.is_admin? || (self.user == user)

    false
  end
end
