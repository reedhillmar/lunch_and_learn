class CountryService < ApplicationService
  def conn
    Faraday.new(url: 'https://restcountries.com')
  end

  def get_url(url)
    conn.get(url)
  end

  def random_country
    json_parse(get_url('/v3.1/all')).sample[:name][:common]
  end
end