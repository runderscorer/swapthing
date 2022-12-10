class Item < ActiveRecord::Base
  belongs_to :wishlist
  has_one_attached :image

  validates_presence_of :name, :price, :wishlist_id

  scope :ordered_by_name, -> { order(name: :asc) }

  def short_url
    self.url.split('.')[1]
  end
end
