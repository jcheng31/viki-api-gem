require 'spec_helper'

describe Viki::EncodeJob, api: true do
	it "fetches a encode job" do
		stub_api 'encode_jobs.json', json_fixture(:encode_jobs) , {:params => {video_id: '1v' ,status: 'scheduled'}}
		described_class.fetch(video_id: "1v", status: 'scheduled') do |response|
			jobs = response.value
			jobs.should be_a_kind_of(Array)
		end
	end

	describe 'create' do
		it 'creates an encode job' do
			stub_api 'encode_jobs.json', '[]', method: :post
			described_class.create("video_id" => '123v', "profile" => 'All') do |response|
				response.error.should be_nil
        response.value.should be_a_kind_of(Array)
			end
		end
	end
end
