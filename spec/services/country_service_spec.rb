require 'rails_helper'

describe CountryService do
  before :each do
    @country = CountryService.new
  end

  context 'helper methods' do
    describe '#conn' do
      it 'is a faraday connection' do
        expect(@country.conn).to be_a Faraday::Connection
      end
    end

    describe '#get_url' do
      it 'returns a response', :vcr do
        response = @country.get_url('/v3.1/all')

        expect(response.status).to eq(200)
      end
    end
  end

  context 'class methods' do
    describe '#random_country' do
      it 'returns the name of a random country', :vcr do
        country = @country.random_country

        expect(country).to be_a String
      end
    end

    describe '#find_country_capital_coordinates' do
      it "returns the coordinates of a given country's capital", :vcr do
        latlon = @country.find_country_capital_coordinates('france')

        expect(latlon).to be_an Array
        expect(latlon).to eq([48.87, 2.33])
      end
    end
  end
end