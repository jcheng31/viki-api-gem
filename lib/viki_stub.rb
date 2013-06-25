require_relative 'viki/spec/stub'

RSpec.configure do |config|
  config.after(:each) do
    Viki::Spec::Stub.remove_async_stub
  end
end

class Viki::Core::Base
  extend Viki::Spec::Stub
end
