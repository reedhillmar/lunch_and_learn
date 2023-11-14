require 'rails_helper'

describe Video do
  it 'exists' do
    data = {
      snippet: {
        title: 'video title'
      },
      id: {
        videoId: 'video id'
      }
    }

    video = Video.new(data)

    expect(video).to be_a Video
    expect(video.title).to eq('video title')
    expect(video.youtube_video_id).to eq('video id')
  end
end