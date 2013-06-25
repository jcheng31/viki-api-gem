require 'viki'
require 'viki_stub'

describe Viki::Spec::Stub do

  describe "async_stub" do

    it "returns rspec stub" do
      Viki::User.async_stub(:fetch).should respond_to :and_yield
      Viki::User.async_stub(:fetch).should respond_to :and_return
    end

    it "does not execute stub without calling Viki.run" do
      Viki::User.async_stub(:fetch).and_yield(OpenStruct.new(value: [{ 'id' => '1u' }]))
      my_spy = double
      my_spy.should_not_receive(:should_not_get_called)
      Viki::User.fetch do |_|
        my_spy.should_not_get_called
      end
    end

    it "does execute stub when Viki.run get called" do
      expect_yield_value = 'yield value'
      Viki::User.async_stub(:fetch).and_yield(expect_yield_value)
      my_spy = double
      my_spy.should_receive(:should_get_called)
      Viki::User.fetch do |yield_value|
        my_spy.should_get_called
        yield_value.should == expect_yield_value
      end
      Viki.run
    end

    it "execute properly when calling in multiple class" do
      Viki::Container.async_stub(:fetch).and_yield(1)
      Viki::User.async_stub(:fetch).and_yield(2)

      first_spy = double
      first_spy.should_receive(:call)
      Viki::Container.fetch do |yield_value|
        first_spy.call
        yield_value.should == 1
      end

      second_spy = double
      second_spy.should_receive(:call)
      Viki::User.fetch do |yield_value|
        second_spy.call
        yield_value.should == 2
      end

      Viki.run
    end

    it "works with multiple stubs on the same message" do
      Viki::User.async_stub(:fetch).with(10).and_yield(1)
      Viki::User.async_stub(:fetch).with(20).and_yield(2)

      first_spy = double
      first_spy.should_receive(:call)
      Viki::User.fetch(10) do |yield_value|
        first_spy.call
        yield_value.should == 1
      end

      second_spy = double
      second_spy.should_receive(:call)
      Viki::User.fetch(20) do |yield_value|
        second_spy.call
        yield_value.should == 2
      end

      Viki.run
    end

    it "works with stubbing multiple messages on the same class" do
      Viki::User.async_stub(:fetch).and_yield(1)
      Viki::User.async_stub(:hey).and_yield(2)

      first_spy = double
      first_spy.should_receive(:call)
      Viki::User.fetch do |yield_value|
        first_spy.call
        yield_value.should == 1
      end

      second_spy = double
      second_spy.should_receive(:call)
      Viki::User.hey do |yield_value|
        second_spy.call
        yield_value.should == 2
      end

      Viki.run
    end

    it "works with multiple Viki.runs in a spec" do
      Viki::Container.async_stub(:fetch).and_yield(nil)
      Viki::User.async_stub(:fetch).and_yield(nil)

      first_spy = double
      first_spy.should_receive(:call).exactly(1)
      Viki::Container.fetch do |_|
        first_spy.call
      end
      Viki.run

      Viki::User.fetch do |_|
      end
      Viki.run
    end
  end
end
