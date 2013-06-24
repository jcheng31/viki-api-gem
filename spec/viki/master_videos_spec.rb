require "spec_helper"

describe Viki::MasterVideo, api: true do
	describe 'create' do
		it 'creates the master video' do
			stub_api 'master_videos.json', '[]', method: :post
			described_class.create("url" => "http://example.com/video.flv", "video_id" => '123v') do |response|
				response.error.should be_nil
			end
		end
	end

	describe 'fetch' do
		it 'creates the master video' do
			stub_api 'master_videos.json', json_fixture(:master_videos) , {:params => {video_id: '123v'}}
			described_class.fetch("video_id" => '123v') do |response|
				jobs = response.value
				jobs.should be_a_kind_of(Hash)
			end
		end
	end
end
