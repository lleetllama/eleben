# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "eleben"
  spec.version       = "0.1.0"
  spec.authors       = ["lleetllama"]
  spec.email         = ["lleetllama@gmail.com"]
  spec.summary       = "A gem for interacting with the Automatic1111 API"
  spec.description   = "This gem provides a Ruby client for the Automatic1111 API."
  spec.homepage      = "https://github.com/lleetllama/eleben"
  spec.files         = ["lib/eleben.rb"]
  spec.require_paths = ["lib"]
  spec.add_dependency "net-http"
  spec.add_development_dependency "rspec"
end
