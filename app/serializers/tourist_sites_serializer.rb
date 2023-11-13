class TouristSitesSerializer
  include JSONAPI::Serializer
  set_type :tourist_site
  set_id { nil }
  attributes :name, :address, :place_id
end