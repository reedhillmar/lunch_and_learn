class Video
  attr_reader :title, :youtube_video_id

  def initialize(video)
    @title = video[:snippet][:title]
    @youtube_video_id = video[:id][:videoId]
  end
end