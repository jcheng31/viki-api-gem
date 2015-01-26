require 'spec_helper'

describe Viki do
  describe 'configure' do
    describe 'max concurrency' do
      it 'sets max concurrency' do
        Viki.configure do |c|
          c.max_concurrency = 100
        end
        expect(Viki.hydra_options[:max_concurrency]).to eq(100)
      end

      it 'sets to 200 if max_concurrency is not specified' do
        Viki.configure do |c|
        end

        expect(Viki.hydra_options[:max_concurrency]).to eq(200)
      end
    end

    describe 'pipelining' do
      it 'enables' do
        Viki.configure do |c|
          c.pipelining = 1
        end
        expect(Viki.hydra_options[:pipelining]).to eq(1)
      end

      it 'disable pipelining if it is not specified' do
        Viki.configure do |c|
        end

        expect(Viki.hydra_options[:pipelining]).to eq(0)
      end
    end
  end

  describe 'run' do
    it 'initializes with hydra_options' do
      Viki.configure do |c|
        c.max_concurrency = 100
        c.pipelining = 1
      end
      Viki.run
      expect(Viki.hydra.max_concurrency).to be(100)
    end
  end
end
