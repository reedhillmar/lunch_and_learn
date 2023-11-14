require 'rails_helper'

describe 'Users API' do
  context 'when a user sends a POST request to /api/v1/users' do
    describe 'happy path' do
      it 'allows a user to create an account', :vcr do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expect(response_body).to have_key :data
        expect(response_body).to be_a Hash

        user_data = response_body[:data]

        expect(user_data).to have_key :id
        expect(user_data[:id]).to be_a String

        expect(user_data).to have_key :type
        expect(user_data[:type]).to eq('user')

        expect(user_data).to have_key :attributes
        expect(user_data[:attributes]).to be_a Hash

        user_attributes = user_data[:attributes]

        expect(user_attributes).to have_key :name
        expect(user_attributes[:name]).to eq('Odell')
        
        expect(user_attributes).to have_key :email
        expect(user_attributes[:email]).to eq('goodboy@ruffruff.com')

        expect(user_attributes).to have_key :api_key
        expect(user_attributes[:api_key]).to be_a String
      end
    end

    describe 'sad path' do
      it 'returns an error if the email is already taken', :vcr do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        post '/api/v1/users', params: user_params, as: :json

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(response_body).to eq({ errors: ["Email has already been taken"] })
      end

      it 'returns an error if the password and password confirmation do not match', :vcr do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'notreats4u'
        }

        post '/api/v1/users', params: user_params, as: :json

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(response_body).to eq({ errors: ["Password confirmation doesn't match Password"] })
      end
    end
  end
end