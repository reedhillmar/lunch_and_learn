class RecipesService < ApplicationService
  def conn
    Faraday.new(url: 'https://api.edamam.com') do |faraday|
      faraday.params["app_id"] = Rails.application.credentials.edamam[:app_id]
      faraday.params["app_key"] = Rails.application.credentials.edamam[:app_key]
      faraday.params["type"] = 'public'
    end
  end

  def country_recipes(country)
    json_parse(
      conn.get("/api/recipes/v2") do |req|
        req.params['q'] = country
      end
    )
  end
end