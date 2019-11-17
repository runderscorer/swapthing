class Item < ActiveRecord::Base
  belongs_to :wishlist
  has_attached_file :image,
                    :style => { thumb: "270x240>", original: "500x500>" },
                    :path => "images/:id/:style/:filename"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_presence_of :name, :price, :wishlist_id
  validate :check_image_url
  before_save :image_remote_url

  scope :ordered_by_name, -> { order(name: :asc) }

  def short_url
    self.url.split('.')[1]
  end

  def check_image_url
    if self.image_url.present? && !URI.parse(self.image_url).is_a?(URI::HTTP || URI::HTTPS)
      errors.add(:image_url, 'Enter a valid image URL')
    end
  end

  def image_remote_url
    if self.image_url.present? && self.image_url_was != self.image_url 
      self.image = URI.parse(self.image_url)
    else
      self.image = nil
    end
  end
end
