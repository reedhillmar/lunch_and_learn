require 'rails_helper'

describe 'Recipes API' do
  it 'sends a list of all recipes by country', :vcr do
    get '/api/v1/recipes?country=thailand'

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(response_body).to have_key :data

    first_recipe = response_body[:data].first

    expect(first_recipe).to have_key :id
    expect(first_recipe[:id]).to eq(nil)

    expect(first_recipe).to have_key :type
    expect(first_recipe[:type]).to eq('recipe')

    expect(first_recipe).to have_key :attributes

    expect(first_recipe[:attributes]).to have_key :title
    expect(first_recipe[:attributes][:title]).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")

    expect(first_recipe[:attributes]).to have_key :url
    expect(first_recipe[:attributes][:url]).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")

    expect(first_recipe[:attributes]).to have_key :country
    expect(first_recipe[:attributes][:country]).to eq("thailand")

    expect(first_recipe[:attributes]).to have_key :image
    expect(first_recipe[:attributes][:image]).to include("https://edamam-product-images.s3.amazonaws.com/web-img/611/61165abc1c1c6a185fe5e67167d3e1f0.jpg")

    expect(first_recipe[:attributes]).to_not have_key :source
    expect(first_recipe[:attributes]).to_not have_key :yield
    expect(first_recipe[:attributes]).to_not have_key :cautions
  end

  it 'sends a list of all recipes by a random country' do
    get '/api/v1/recipes?country='

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(response_body).to have_key :data

    first_recipe = response_body[:data].first

    if first_recipe
      expect(first_recipe).to have_key :id
      expect(first_recipe[:id]).to eq(nil)

      expect(first_recipe).to have_key :type
      expect(first_recipe[:type]).to eq('recipe')

      expect(first_recipe).to have_key :attributes
      expect(first_recipe[:attributes]).to have_key :title
      expect(first_recipe[:attributes]).to have_key :url
      expect(first_recipe[:attributes]).to have_key :country
      expect(first_recipe[:attributes]).to have_key :image
    end
  end

  it 'sends an empty data array if no country given or no matches', :vcr do
    get '/api/v1/recipes?country= '

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response_body).to eq({"data": []})

    get '/api/v1/recipes?country=asdfjaioefjiowe'

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response_body).to eq({"data": []})
  end
end