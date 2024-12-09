class Item < ActiveRecord::Base
  belongs_to :wishlist
  has_one_attached :image, service: :amazon

  validates_presence_of :name, :price, :wishlist_id
  validate :url_format
  validate :image_url_format
  validate :image_file_type

  before_save :attach_image

  scope :ordered_by_name, -> { order(name: :asc) }

  def vendor_name
    return '' unless url

    URI.parse(url).host
  end

  private

  def attach_image
    return unless image_url

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
    Rails.logger.info { "Attaching file - #{filename}..." }

    # Create ActiveStorage records and upload to S3
    image.attach(io: downloaded_image, filename: filename)
  rescue => e
    Rails.logger.info { "Error attaching image - #{e}" }
    errors.add(:image_url, image&.error)
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

  def image_file_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/svg image/gif))
      errors.add(:image_url, 'Enter a URL for a valid image file type')
    end
  end
end
