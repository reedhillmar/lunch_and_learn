require 'rails_helper'

describe 'Sessions API' do
  context 'when a user sends a POST request to /api/v1/sessions' do
    describe 'happy path' do
      it 'allows a user to login', :vcr do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        session_params = {
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf'
        }

        post '/api/v1/sessions', params: session_params, as: :json

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(response_body).to have_key :data
        expect(response_body).to be_a Hash

        session_data = response_body[:data]

        expect(session_data).to have_key :id
        expect(session_data[:id]).to be_a String

        expect(session_data).to have_key :type
        expect(session_data[:type]).to eq('user')

        expect(session_data).to have_key :attributes
        expect(session_data[:attributes]).to be_a Hash

        session_attributes = session_data[:attributes]

        expect(session_attributes).to have_key :name
        expect(session_attributes[:name]).to eq('Odell')
        
        expect(session_attributes).to have_key :email
        expect(session_attributes[:email]).to eq('goodboy@ruffruff.com')

        expect(session_attributes).to have_key :api_key
        expect(session_attributes[:api_key]).to be_a String
        expect(session_attributes[:api_key]).to eq(User.last.api_key)
      end
    end

    describe 'sad path' do
      it 'returns an error if email is invalid' do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        session_params = {
          email: 'notreal@email.com',
          password: 'treats4lyf'
        }

        post '/api/v1/sessions', params: session_params, as: :json

        expect(response.status).to eq(401)
        expect(response.body).to eq("{\"errors\":\"Invalid credentials\"}")
      end

      it 'returns an error if password is invalid' do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        session_params = {
          email: 'goodboy@ruffruff.com',
          password: 'wrong_password'
        }

        post '/api/v1/sessions', params: session_params, as: :json

        expect(response.status).to eq(401)
        expect(response.body).to eq("{\"errors\":\"Invalid credentials\"}")
      end

      it 'returns an error if no email provided' do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        session_params = {
          password: 'treats4lyf'
        }

        post '/api/v1/sessions', params: session_params, as: :json

        expect(response.status).to eq(401)
        expect(response.body).to eq("{\"errors\":\"Invalid credentials\"}")
      end

      it 'returns an error if no password provided' do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }

        post '/api/v1/users', params: user_params, as: :json

        session_params = {
          email: 'goodboy@ruffruff.com'
        }

        post '/api/v1/sessions', params: session_params, as: :json

        expect(response.status).to eq(401)
        expect(response.body).to eq("{\"errors\":\"Invalid credentials\"}")
      end
    end
  end
end