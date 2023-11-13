class PlacesService < ApplicationService
  def conn
    Faraday.new(url: 'https://api.geoapify.com') do |faraday|
      faraday.params['apiKey'] = Rails.application.credentials.geoapify[:apiKey]
    end
  end

  def tourist_sites(lon, lat)
    json_parse(
      conn.get('/v2/places') do |req|
        req.params['categories'] = 'tourism.sights'
        req.params['filter'] = "circle:#{lon},#{lat},1000"
      end
    )
  end
end