class LearningResources
  attr_reader :country, :video, :images

  def initialize(country)
    @country = country
    @video = make_video(country)
    @images = make_images(country)
  end

  def country_video(country)
    YoutubeService.new.country_video(country)[:items].first
  end

  def country_images(country)
    PexelsService.new.country_images(country)[:photos]
  end

  def make_video(country)
    video = country_video(country)
    if video
      Video.new(video)
    else
      {}
    end
  end

  def make_images(country)
    images = country_images(country)
    images.map do |image|
      Image.new(image)
    end
  end
end