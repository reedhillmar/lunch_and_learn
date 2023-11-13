require 'rails_helper'

describe 'Learning Resources API' do
  it 'sends a list of videos and images by country', :vcr do
    get '/api/v1/learning_resources?country=laos'

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(response_body).to have_key :data
    expect(response_body).to be_a Hash

    learning_resources_data = response_body[:data]

    expect(learning_resources_data).to have_key :id
    expect(learning_resources_data[:id]).to eq(nil)

    expect(learning_resources_data).to have_key :type
    expect(learning_resources_data[:type]).to eq('learning_resource')

    expect(learning_resources_data).to have_key :attributes
    expect(learning_resources_data[:attributes]).to be_a Hash

    learning_resources_attributes = learning_resources_data[:attributes]

    expect(learning_resources_attributes).to have_key :country
    expect(learning_resources_attributes[:country]).to eq('laos')

    expect(learning_resources_attributes).to have_key :video
    expect(learning_resources_attributes[:video]).to be_a Hash
    expect(learning_resources_attributes[:video]).to have_key :title
    expect(learning_resources_attributes[:video][:title]).to eq('A Super Quick History of Laos')
    expect(learning_resources_attributes[:video]).to have_key :youtube_video_id
    expect(learning_resources_attributes[:video][:youtube_video_id]).to eq('uw8hjVqxMXw')

    expect(learning_resources_attributes).to have_key :images
    expect(learning_resources_attributes[:images]).to be_an Array
    
    first_image = learning_resources_attributes[:images].first

    expect(first_image).to have_key :alt_tag
    expect(first_image[:alt_tag]).to eq('Stone Castle Wall Surrounded With Green Grass')
    
    expect(first_image).to have_key :url
    expect(first_image[:url]).to eq('https://www.pexels.com/photo/stone-castle-wall-surrounded-with-green-grass-924631/')
  end
end