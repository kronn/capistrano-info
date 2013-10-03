# -*- encoding: utf-8 -*-
require File.expand_path('../lib/capistrano-info/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Matthias Viehweger"]
  gem.email         = ["kronn@kronn.de"]
  gem.summary       = 'output of remote information through capistrano'
  gem.description   = <<-EOT
A set of capistrano recipes for outputting various info from the remote server.

Features include:
- tail -f of a logfile (info:tail)
- deployed version (info:version)
EOT
  gem.homepage      = 'https://github.com/kronn/capistrano-info'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "capistrano-info"
  gem.require_paths = ["lib"]
  gem.version       = Capistrano::Info::VERSION

  gem.add_dependency 'capistrano', '>= 2.9.0', '< 3.0.0'
end
