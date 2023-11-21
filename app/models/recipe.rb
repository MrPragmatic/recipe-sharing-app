class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :title, presence: true
  validates :body, length: { minimum: 50 }
  validates :video_url, format: { with: %r{\A(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})\z}, allow_blank: true }
  validates :featured_image, presence: true, format: URI::regexp(%w{ https })

  def validate_video_url_format_if_present
    return if video_url.blank?

    unless video_url.match?(%r{\A(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})\z})
      errors.add(:video_url, 'has an invalid format')
    end
  end

  validate :at_least_one_ingredient

  def at_least_one_ingredient
    errors.add(:base, 'At least one ingredient is required') if ingredients.empty?
  end
end