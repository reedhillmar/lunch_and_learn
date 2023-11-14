require 'rails_helper'

describe Image do
  it 'exists' do
    data = {
      alt: 'alt tag',
      url: 'image url'
    }

    image = Image.new(data)

    expect(image).to be_an Image
    expect(image.alt_tag).to eq('alt tag')
    expect(image.url).to eq('image url')
  end
end