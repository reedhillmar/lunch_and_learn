class PlacesServices < ApplicationService
  def conn
    Faraday.new(url: 'https://api/geoapify.com/v2') do |faraday|
      faraday.params['apiKey'] = Rails.application.credentials.geoapify[:api_key]
    end
  end
end