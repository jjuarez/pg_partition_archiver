# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pg_partition_archiver/version'

Gem::Specification.new do |spec|
  spec.name          = 'pg_partition_archiver'
  spec.version       = PgPartitionArchiver::VERSION
  spec.authors       = ['Javier Juarez']
  spec.email         = ['javier.juarez@gmail.com']

  spec.summary       = 'A PosgreSQL serial partition manager'
  spec.description   = 'A gem to help you to take in fit PosgreSQL serial partitions'
  spec.homepage      = 'https://github.com/jjuarez/pg_partition_archiver'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'pg', '~> 0.13'
  spec.add_dependency 'thor', '~> 0.19'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
