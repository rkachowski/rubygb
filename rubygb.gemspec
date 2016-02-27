# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + "/lib/rubygb/version"

Gem::Specification.new do |gem|
  gem.name          = "rubygb"
  gem.version       = Rubygb::VERSION
  gem.summary       = "Create gameboy roms on osx"
  gem.description   = "A stupid gem that comes bundled with an osx compatible version of rgbds"
  gem.authors       = ["Donald Hutchison"]
  gem.email         = ["git@toastymofo.net"]
  gem.homepage      = "https://github.com/rkachowski/rubygb"
  gem.license       = "MIT"

  gem.files         = Dir["{**/}{.*,*}"].select{ |path| File.file?(path) && path !~ /^pkg/ }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = "~> 2.0"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "pry-byebug"

  gem.add_runtime_dependency "thor", "~> 0.19"
end
