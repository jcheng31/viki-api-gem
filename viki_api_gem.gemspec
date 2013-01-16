# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "viki/version"

Gem::Specification.new do |s|
  s.name        = "viki-api-gem"
  s.version     = Viki::VERSION
  s.authors     = ["Albert Callarisa Roca", "Fadhli Rahim"]
  s.email       = ["engineering@viki.com"]
  s.homepage    = "http://dev.viki.com"
  s.summary     = "A thin wrapper around the Viki V4 API"
  s.description = "Viki API gem is an official wrapper gem for the Viki V4 API."

  s.rubyforge_project = "viki-api-gem"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~> 2.11"
  s.add_development_dependency "vcr", "~> 2.3"
  s.add_development_dependency "webmock", "~> 1.9"
  s.add_development_dependency "timecop", "~> 0.5"

  s.add_runtime_dependency     "oj", "~> 1.4"
  s.add_runtime_dependency     "typhoeus", "~> 0.5"
  s.add_runtime_dependency     "addressable", "~> 2.3"
end
