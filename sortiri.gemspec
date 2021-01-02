# frozen_string_literal: true

require_relative 'lib/sortiri/version'

Gem::Specification.new do |spec|
  spec.name          = 'sortiri'
  spec.version       = Sortiri::VERSION
  spec.authors       = ['H. Can Yıldırım']
  spec.email         = ['huseyin@fabrikator.io']

  spec.summary       = 'Sortiri is a clean and lightweight solution for making ActiveRecord::Base objects sortable.'
  spec.homepage      = 'https://github.com/fabrikatorio/sortiri'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/fabrikatorio/sortiri'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 4.2'
  spec.add_dependency 'activesupport', '>= 4.2'

  spec.add_development_dependency 'mocha', '~> 1.12'
  spec.add_development_dependency 'rubocop', '~> 1.7'
  spec.add_development_dependency 'rubocop-rake', '~> 0.5.1'
  spec.add_development_dependency 'sqlite3', '~> 1.4.0'
  spec.add_development_dependency 'temping', '~> 3.10'
end
