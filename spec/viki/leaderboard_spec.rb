require "spec_helper"

describe Viki::Leaderboard, api: true do
  it "fetches subtitle leaderboard" do
    stub_api 'leaderboards/subtitle.json', Oj.dump([{ 'id' => '1u' }, { 'id' => '2u' }])
    described_class.fetch(type: 'subtitle') do |response|
      expect(response.value).to eq [{ 'id' => '1u' }, { 'id' => '2u' }]
    end
  end

  it "fetches subtitle leaderboard with language" do
    stub_api 'leaderboards/subtitle.json', Oj.dump([{ 'id' => '1u' }, { 'id' => '2u' }]), language: 'en'
    described_class.fetch(type: 'subtitle', language: 'en') do |response|
      expect(response.value).to eq [{ 'id' => '1u' }, { 'id' => '2u' }]
    end
  end

  it "fetches segment leaderboard" do
    stub_api 'leaderboards/segment.json', Oj.dump([{ 'id' => '1u' }, { 'id' => '2u' }])
    described_class.fetch(type: 'segment') do |response|
      expect(response.value).to eq [{ 'id' => '1u' }, { 'id' => '2u' }]
    end
  end
end
