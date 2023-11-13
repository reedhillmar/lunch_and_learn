class CountryService < ApplicationService
  def conn
    Faraday.new(url: 'https://restcountries.com')
  end

  def random_country
    json_parse(get_url('/v3.1/all')).sample[:name][:common]
  end
end