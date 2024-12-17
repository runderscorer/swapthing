class Item < ActiveRecord::Base
  belongs_to :wishlist
  has_one_attached :image, service: :amazon

  validates_presence_of :name, :price, :wishlist_id
  validate :url_format
  validate :image_url_format

  before_validation :attach_image

  scope :ordered_by_name, -> { order(name: :asc) }

  ALLOWED_TYPES = %w(image/jpg image/jpeg image/png image/svg image/gif)

  def vendor_name
    return '' unless url

    URI.parse(url).host
  rescue
    nil
  end

  private

  def attach_image
    return if image_url.blank?
    return unless image_url_changed?

    # Parse string and download image
    parser = URI::Parser.new
    url = parser.parse(image_url)
    downloaded_image = url.open

    filename = url.path.match(/(?!.*\/).+/).to_s 
    # Negative lookahead  (?!
    # Match zero or more of any character .*
    # Match a forward slash \/
    # End negative lookahead )
    # Match one or more characters .+

    unless ALLOWED_TYPES.include?(downloaded_image.content_type)
      errors.add(:image_url, 'Enter a valid image URL or leave this blank')
      self.image_url = nil
      return false
    end

    Rails.logger.info { "Attaching file - #{filename}..." }

    # Create ActiveStorage records and upload to S3
    image.attach(io: downloaded_image, filename: filename)
  rescue => e
    Rails.logger.info { "Error attaching image - #{e}" }
    errors.add(:image_url, image&.errors&.first)
    false
  end

  def url_format
    return if url.blank?

    errors.add(:url, 'Enter a valid URL or leave this blank') unless URI::regexp =~ url
  end

  def image_url_format
    return if image_url.blank?

    image_uri = URI.parse(image_url)

    if image_uri && !image_uri.is_a?(URI::HTTP || URI::HTTPS)
      errors.add(:image_url, 'Enter a valid image URL or leave this blank')
    end
  rescue
    errors.add(:image_url, 'Enter a valid image URL or leave this blank')
  end
end
