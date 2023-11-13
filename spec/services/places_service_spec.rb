require 'rails_helper'

describe PlacesService do
  before :each do
    @place = PlacesService.new
  end

  context 'helper methods' do
    describe '#conn' do
      it 'is a faraday connection' do
        expect(@place.conn).to be_a Faraday::Connection
      end
    end
  end

  context 'class methods' do
    describe '#tourist_sites' do
      it 'returns tourist sites by coordiantes', :vcr do
      paris = @place.tourist_sites(2.33, 48.87)

      expect(paris).to be_a Hash
      expect(paris).to have_key :features

      paris_details = paris[:features]

      expect(paris_details).to be_an Array
      expect(paris_details.first).to be_a Hash
      expect(paris_details.first).to have_key :properties

      first_properties = paris_details.first[:properties]

      expect(first_properties).to have_key :name
      expect(first_properties[:name]).to be_a String

      expect(first_properties).to have_key :formatted
      expect(first_properties[:formatted]).to be_a String

      expect(first_properties).to have_key :place_id
      expect(first_properties[:place_id]).to be_a String
      end
    end
  end
end