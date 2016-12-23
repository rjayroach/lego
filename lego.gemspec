# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lego/version'

Gem::Specification.new do |spec|
  spec.name          = "lego"
  spec.version       = Lego::VERSION
  spec.authors       = ["Robert Roach"]
  spec.email         = ["rjayroach@gmail.com"]

  spec.summary       = %q{Create a micro service component with Ember and Rails}
  spec.description   = %q{Creates a Rails 5 API server and a corresponding Ember Engine}
  spec.homepage      = 'https://c2p4.com/lego'

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

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "pry", "~> 0.10.4"
  spec.add_dependency "awesome_print"
  spec.add_dependency "rails"
  spec.add_dependency "spring"
end
