class PlacesServices < ApplicationService
  def conn
    Faraday.new(url: 'https://api/geoapify.com/v2') do |faraday|
      faraday.params['apiKey'] = Rails.application.credentials.geoapify[:api_key]
    end
  end

  def tourist_sites(lon, lat)
    json_parse(
      conn.get("/places") do |req|
        req.params['categories'] = 'tourism.sights'
        req.params['filter'] = "circle:#{lon},#{lat},1000"
      end
    )
  end
end