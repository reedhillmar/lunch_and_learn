class LearningResourceSerializer
  include JSONAPI::Serializer
  set_type :learning_resource
  set_id { nil }
  attributes :country, :video, :images
end