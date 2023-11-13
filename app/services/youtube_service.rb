class YoutubeService < ApplicationService
  def conn
    Faraday.new(url: 'https://youtube.googleapis.com') do |faraday|
      faraday.params["key"] = Rails.application.credentials.youtube[:key]
      faraday.params["type"] = 'video'
      faraday.params["part"] = 'snippet'
      faraday.params["channelId"] = 'UCluQ5yInbeAkkeCndNnUhpw'
      faraday.params['maxResults'] = 1
    end
  end

  def country_video(country)
    json_parse(
      conn.get("/youtube/v3/search") do |req|
        req.params['q'] = country
      end
    )
  end
end