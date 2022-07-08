class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true, touch: true

  validates :name, :link, presence: true
  validate :validate_link

  def validate_link
    errors.add(:link, 'url invalid') unless valid_url?
  end

  def valid_url?
    uri = URI.parse(link)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
