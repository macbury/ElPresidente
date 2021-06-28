require_relative 'lib/elpresidente/version'

Gem::Specification.new do |spec|
  spec.name          = "elpresidente"
  spec.version       = Elpresidente::VERSION
  spec.authors       = ["Arkadiusz Buras"]
  spec.email         = ["me@macbury.ninja"]

  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = "https://duckduckgo.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'async-redis', '~> 0.6.0'
  spec.add_dependency 'slack-ruby-block-kit', '~> 0.16'
  spec.add_dependency 'zeitwerk', '~> 2.4.2'
  spec.add_dependency 'async-container', '~> 0.16.11'
  spec.add_dependency "async", "~> 1.29"
  spec.add_dependency "dry-cli", "~> 0.6"
  spec.add_dependency 'async-http', '~> 0.56.3'
  spec.add_dependency "rufus-scheduler", ">= 3.6.0"
  spec.add_dependency 'pry'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'async-websocket', '~> 0.8.0'
  spec.add_dependency 'slack-ruby-client', "~> 0.17.0"
  spec.add_dependency 'activesupport', '~> 6.1.4'
  spec.add_dependency 'google_drive'
  spec.add_dependency 'nokogiri', '~> 1.11'
  spec.add_dependency 'addressable', '~> 2.7'
  spec.add_dependency 'fugit', '~> 1.5'
end