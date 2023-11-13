class Api::V1::TouristSitesController < ApplicationController
  def index
    render json: TouristSitesSerializer.new(make_tourist_sites(country_tourist_sites(params[:country])))
  end

  private

  def country_tourist_sites(country)
    latlon = CountryService.new.find_country_capital_coordinates(country)
    lat = latlon.first
    lon = latlon.last

    PlacesServices.new.tourist_sites(lon, lat)[:features]
  end

  def make_tourist_sites(tourist_sites)
    tourist_sites.map do |tourist_site|
      TouristSite.new(tourist_site)
    end
  end
end