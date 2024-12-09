require 'spec_helper'

describe Item, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :price }
    it { should validate_presence_of :wishlist_id }
  end

  context 'associations' do
    it { should belong_to :wishlist }
  end

  it 'should allow a blank url' do
    item = build(:item, url: nil)
    item.save

    assert item
  end

  it 'should return an error message if the url is invalid' do
    item = build(:item, url: 'invalid url')
    item.save

    assert_equal 'Enter a valid URL or leave this blank', item.errors[:url].last
  end

  it 'should allow a blank image_url' do
    item = build(:item, image_url: nil)
    item.save

    assert item
  end

  it 'should return an error message if the image_url is invalid' do
    item = build(:item, image_url: 'invalid url')
    item.save

    assert_equal 'Enter a valid image URL or leave this blank', item.errors[:image_url].last
  end
end
