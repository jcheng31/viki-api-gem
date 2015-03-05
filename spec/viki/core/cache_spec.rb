require 'spec_helper'

describe Viki::Core::Cache do
  describe 'generate_key' do
    it 'generates a key' do
      url = 'http://api.com/v4/containers/25963c/episodes.json?app=1a'
      expect(described_class.generate_key(url)).to eq('viki-api-gem./v4/containers/25963c/episodes.json-@role=0-app=1a')
    end

    it 'ignores t and sig parameters' do
      url = 'http://api.com/v4/containers/25963c/episodes.json?app=1a&sig=abcd123&t=1425530280&sort=number'
      expect(described_class.generate_key(url)).to eq('viki-api-gem./v4/containers/25963c/episodes.json-@role=0-app=1a-sort=number')
    end

    it 'sets roles from token' do
      url = 'http://api.com/v4/containers/25963c/episodes.json?app=1a&sig=abcd123&t=1425530280&sort=number&token=token_25'
      expect(described_class.generate_key(url)).to eq('viki-api-gem./v4/containers/25963c/episodes.json-@role=25-app=1a-sort=number')
    end

    it 'generates a key from url' do
      url = 'http://api.com/v4/containers/25963c/episodes.json?app=1a&blocked=true&direction=asc&page=1&per_page=25&sig=abcd123&sort=number&t=1425530280&token=token_25'
      expect(described_class.generate_key(url)).to eq('viki-api-gem./v4/containers/25963c/episodes.json-@role=25-app=1a-blocked=true-direction=asc-page=1-per_page=25-sort=number')
    end

    it 'generates same key with different parameter order' do
      url = 'http://api.com/v4/containers/25963c/episodes.json?app=1a&token=token_25&blocked=true&page=1&per_page=25&sig=abcd123&direction=asc&sort=number&t=1425530280'
      expect(described_class.generate_key(url)).to eq('viki-api-gem./v4/containers/25963c/episodes.json-@role=25-app=1a-blocked=true-direction=asc-page=1-per_page=25-sort=number')
    end
  end
end