class Item < ActiveRecord::Base
  belongs_to :wishlist
  has_attached_file :image,
                    :styles => { thumb: "270x240>", original: "500x500>" },
                    :storage => :s3,
                    :s3_credentials => Proc.new {|a| a.instance.s3_credentials},
                    :path => "images/:id/:style/:filename"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_presence_of :name, :price, :wishlist_id
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

  def s3_credentials
    { bucket: ENV['S3_BUCKET'],
      access_key_id: ENV['S3_ACCESS_KEY'],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
      s3_region: ENV['AWS_REGION']
    }
  end
end
