class Item < ActiveRecord::Base
  belongs_to :wishlist  
  has_attached_file :image, :styles => { :thumb => "270x240>" }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_presence_of :name, :price
  before_save :image_remote_url

  def short_url
    self.url.split('.')[1]
  end

  def image_remote_url
    if self.image_url.present?
      self.image = URI.parse(self.image_url)
      # Assuming url_value is http://example.com/photos/face.png
      # avatar_file_name == "face.png"
      # avatar_content_type == "image/png"
      @image_remote_url = self.image_url
    else
      self.image = nil
    end
  end
end