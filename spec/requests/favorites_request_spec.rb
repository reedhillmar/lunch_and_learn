require 'rails_helper'

describe 'Favorites API' do
  context 'when a user sends a post request to /api/v1/favorites' do
    describe 'happy path' do
      it 'allows a user to favorite a recipe' do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        favorite_params = {
          api_key: User.last.api_key,
          country: 'thailand',
          recipe_link: 'https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html',
          recipe_title: "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)"
        }

        post '/api/v1/favorites', params: favorite_params, as: :json

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expect(response.body).to have_key :success
        expect(response.body[:status]).to eq('Favorite added successfully')
      end
    end
  end
end