require 'rails_helper'

describe LearningResources do
  it 'exists', :vcr do
    learning_resources = LearningResources.new('thailand')

    expect(learning_resources).to be_a LearningResources
    expect(learning_resources.country).to eq('thailand')
    expect(learning_resources.video).to be_a Video
    expect(learning_resources.images).to be_an Array
    expect(learning_resources.images.first).to be_an Image
  end

  it 'can find a video from youtube', :vcr do
    video = LearningResources.new('thailand').country_video('thailand')

    expect(video).to be_a Hash
    expect(video).to have_key(:id)
    expect(video[:id]).to have_key(:videoId)
    expect(video).to have_key(:snippet)
    expect(video[:snippet]).to have_key(:title)
  end

  it 'can find images from pexels', :vcr do
    images = LearningResources.new('thailand').country_images('thailand')

    expect(images).to be_an Array
    expect(images.first).to be_a Hash
    expect(images.first).to have_key(:url)
    expect(images.first).to have_key(:alt)
  end

  it 'can make a video object', :vcr do
    video = LearningResources.new('thailand').make_video('thailand')

    expect(video).to be_a Video
  end
  
    it 'returns an empty array if no video is found', :vcr do
      video = LearningResources.new('asdf').make_video('asdf')
  
      expect(video).to eq({})
    end

  it 'can make an image array with image objects', :vcr do
    images = LearningResources.new('thailand').make_images('thailand')

    expect(images).to be_an Array
    expect(images.first).to be_an Image
  end

  it 'returns an empty array if no images are found', :vcr do
    images = LearningResources.new('asdf').make_images('asdf')

    expect(images).to eq([])
  end
end