# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kobra/version'

Gem::Specification.new do |spec|
  spec.name          = "kobra_client"
  spec.version       = Kobra::VERSION
  spec.authors       = ["Lukas Lindqvist"]
  spec.email         = ["lukas@lukaslindqvist.se"]

  spec.summary       = "Client library for KOBRA"
  spec.description   = "User for access to the new KOBRA, API-account requireed."
  spec.homepage      = "https://github.com/ljukas/kobra_client"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #Development dependencies
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.1.0"

  #Runtime dependencies
  spec.add_runtime_dependency "json_pure", "~> 2.0.2"
  spec.add_runtime_dependency "rest-client", "~> 2.0.0"
end
