class Image
  attr_reader :alt_tag, :url

  def initialize(image)
    @alt_tag = image[:alt]
    @url = image[:url]
  end
end