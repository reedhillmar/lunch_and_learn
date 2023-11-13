require 'rails_helper'

describe 'Tourist Sites API' do
  it 'sends a list of tourist sites near the capital city of a given country' do
    get '/api/v1/tourist_sites?country=france'

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be be_successful

    expect(response_body).to have_key :data
    expect(response_body[:data]).to be_an Array

    first_site = response_body[:data].first

    expect(first_site).to have_key :id
    expect(first_site[:id]).to eq(nil)

    expect(first_site).to have_key :type
    expect(first_site[:type]).to eq('tourist_site')

    expect(first_site).to have_key :attributes
    expect(first_site[:attributes]).to be_a Hash

    first_site_attributes = first_site[:attributes]

    expect(first_site_attributes).to have_key :name
    expect(first_site_attributes[:name]).to eq("Tour de l'horloge")

    expect(first_site_attributes).to have_key :address
    expect(first_site_attributes[:address]).to eq("Tour de l'horloge, Allée de l'Horloge, 23200 Aubusson, France")

    expect(first_site_attributes).to have_key :place_id
    expect(first_site_attributes[:place_id]).to eq("something here?")
  end
end