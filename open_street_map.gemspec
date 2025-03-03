lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_street_map/version'

Gem::Specification.new do |spec|
  spec.name = 'open_street_map'
  spec.version = OpenStreetMap::VERSION
  spec.authors = ['JungleCoders', 'Anton Bogdanov']
  spec.email = ['kortirso@gmail.com']
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.summary = 'OpenStrretMap API'
  spec.description = 'Integration with OpenStreetMap API'
  spec.homepage = 'https://github.com/WebGents/open_street_map'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5.1'

  spec.add_development_dependency 'bundler', '>= 2.2.33'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.23'
  spec.add_dependency 'httparty', '~> 0.17'
  spec.add_dependency 'libxml-ruby', '~> 5.0.3'
end
