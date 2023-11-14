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

        expect(User.last.favorites.count).to eq(0)

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

        expect(response_body).to have_key :success
        expect(response_body[:success]).to eq('Favorite added successfully')

        expect(User.last.favorites.count).to eq(1)
        
        user_favorite = User.last.favorites.first

        expect(user_favorite.country).to eq('thailand')
        expect(user_favorite.recipe_link).to eq('https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html')
        expect(user_favorite.recipe_title).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
        expect(user_favorite.user_id).to eq(User.last.id)
      end
    end

    describe 'sad path' do
      it "doesn't allow an invalid api key" do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        favorite_params = {
          api_key: 'thisisthewrongkey',
          country: 'thailand',
          recipe_link: 'https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html',
          recipe_title: "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)"
        }

        post '/api/v1/favorites', params: favorite_params, as: :json

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(401)
        expect(response_body).to eq({ errors: 'Invalid API Key' })
      end
    end
  end

  context 'when a user sends a get request to /api/v1/favorites' do
    describe 'happy path' do
      it "returns all of a user's favorites" do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        favorite_params1 = {
          api_key: User.last.api_key,
          country: 'thailand',
          recipe_link: 'https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html',
          recipe_title: "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)"
        }

        post '/api/v1/favorites', params: favorite_params1, as: :json

        favorite_params2 = {
          api_key: User.last.api_key,
          country: 'india',
          recipe_link: 'http://www.foodrepublic.com/2011/05/12/east-indian-negroni-cocktail-recipe',
          recipe_title: "East Indian Negroni Cocktail Recipe"
        }

        post '/api/v1/favorites', params: favorite_params2, as: :json

        get "/api/v1/favorites?api_key=#{User.last.api_key}"

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(response_body).to have_key :data
        expect(response_body[:data]).to be_an Array
        expect(response_body[:data].count).to eq(2)

        first_favorite = response_body[:data].first

        expect(first_favorite).to have_key :id
        expect(first_favorite[:id]).to be_a String

        expect(first_favorite).to have_key :type
        expect(first_favorite[:type]).to eq('favorite')

        expect(first_favorite).to have_key :attributes
        expect(first_favorite[:attributes]).to be_a Hash

        first_favorite_attributes = first_favorite[:attributes]

        expect(first_favorite_attributes).to have_key :recipe_title
        expect(first_favorite_attributes[:recipe_title]).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")

        expect(first_favorite_attributes).to have_key :recipe_link
        expect(first_favorite_attributes[:recipe_link]).to eq('https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html')

        expect(first_favorite_attributes).to have_key :country
        expect(first_favorite_attributes[:country]).to eq("thailand")

        expect(first_favorite_attributes).to have_key :created_at
        expect(first_favorite_attributes[:created_at]).to be_a String
      end

      it 'returns data as an empty array if the user has no favorites' do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        get "/api/v1/favorites?api_key=#{User.last.api_key}"

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response_body).to eq({"data": []})
      end
    end

    describe 'sad path' do
      it "doesn't allow an invalid api key" do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        get '/api/v1/favorites?api_key=invalidapikey'

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(401)
        expect(response_body).to eq({ errors: 'Invalid API Key' })
      end
    end
  end
end