class Api::V1::LearningResourcesController < ApplicationController
  def index
    if params[:country]
      country = params[:country]
      render json: LearningResourceSerializer.new(make_learning_resources(country))
    end
  end

  private

  def make_learning_resources(country)
    LearningResources.new(country)
  end

  def country_video(country)
    YouTubeService.new.country_video(country)[:items]
  end

  def country_images(country)
    PexelsService.new.country_images(country)[:photos]
  end
end