$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'images_client/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'images_client'
  spec.version     = ImagesClient::VERSION
  spec.authors     = ['Svetlozar Mihaylov']
  spec.email       = ['svetliomihailov@gmail.com']
  spec.homepage    = ''
  spec.summary     = 'ImagesClient is a Rails engine designed to be used with the Raketa Images.'
  spec.description = ''
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'faraday'
  spec.add_dependency 'rails', '>= 5.1.0'

  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3'
end
