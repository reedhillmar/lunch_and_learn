class LearningResources
  attr_reader :country, :video, :images

  def initialize(country)
    @country = country
    @video = make_video(country)
    @images = make_images(country)
  end


  def country_video(country)
    YouTubeService.new.country_video(country)[:items]
  end

  def country_images(country)
    PexelsService.new.country_images(country)[:photos]
  end
end