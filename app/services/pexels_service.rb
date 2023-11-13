class PexelsService < ApplicationService
  def conn
    Faraday.new(url: 'https://api.pexels.com') do |faraday|
      faraday.headers['authorization'] = Rails.application.credentials.pexels[:authorization]
      faraday.params['per_page'] = 10
    end
  end

  def country_images(country)
    json_parse(
      conn.get('/v1/search') do |req|
        req.params['query'] = country
      end
    )
  end
end