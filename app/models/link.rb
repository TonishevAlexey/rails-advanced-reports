class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :link, presence: true
  validate :validate_link

  def validate_link
    unless valid_url?
    errors.add(:link, "url invalid")
    end
  end
  def valid_url?
    uri = URI.parse(self.link)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
