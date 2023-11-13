require 'rails_helper'

describe 'Learning Resources API' do
  it 'sends a list of videos and images by country', :vcr do
    get '/api/v1/learning_resources?country=laos'

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(response_body).to have_key :data

    
  end
end