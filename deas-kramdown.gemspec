# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "deas-kramdown/version"

Gem::Specification.new do |gem|
  gem.name        = "deas-kramdown"
  gem.version     = Deas::Kramdown::VERSION
  gem.authors     = ["Kelly Redding", "Collin Redding"]
  gem.email       = ["kelly@kellyredding.com", "collin.redding@me.com"]
  gem.summary     = %q{Deas template engine for Kramdown templates}
  gem.description = %q{Deas template engine for Kramdown templates}
  gem.homepage    = "http://github.com/redding/deas-kramdown"
  gem.license     = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency("assert", ["~> 2.16.3"])

  gem.add_dependency("deas",     ["~> 0.43.4"])
  gem.add_dependency("kramdown", ["~> 1.10"])

end
