require 'spec_helper'

describe Viki do
  describe 'configure' do
    it 'sets max concurrency' do
      Viki.configure do |c|
        c.max_concurrency = 100
      end
      expect(Viki.hydra_options).to eq(max_concurrency: 100)
    end

    it 'sets to 200 if max_concurrency is not specified' do
      Viki.configure do |c|
      end

      expect(Viki.hydra_options).to eq(max_concurrency: 200)
    end
  end

  describe 'run' do
    it 'initializes with hydra_options' do
      Viki.configure do |c|
        c.max_concurrency = 100
      end
      Viki.run
      expect(Viki.hydra.max_concurrency).to be(100)
    end
  end
end
