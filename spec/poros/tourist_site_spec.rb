require 'rails_helper'

describe TouristSite do
  it 'exists' do
    data = {
      properties: {
        name: 'a place',
        formatted: 'an address',
        place_id: 'a place id'
      }
    }

    site = TouristSite.new(data)

    expect(site).to be_a TouristSite
    expect(site.name).to eq('a place')
    expect(site.address).to eq('an address')
    expect(site.place_id).to eq('a place id')
  end
end