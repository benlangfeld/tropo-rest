# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tropo-rest/version"

Gem::Specification.new do |s|
  s.name        = "tropo-rest"
  s.version     = TropoREST::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Langfeld"]
  s.email       = ["ben@langfeld.me"]
  s.homepage    = "https://github.com/benlangfeld/tropo-rest"
  s.summary     = %q{A rubygem to wrap the Tropo REST API}

  s.rubyforge_project = "tropo-rest"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'httparty'
  s.add_dependency 'pry'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'yard'
end
