# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + "/lib/rubygb/version"

Gem::Specification.new do |gem|
  gem.name          = "rubygb"
  gem.version       = Rubygb::VERSION
  gem.summary       = "TODO"
  gem.description   = "TODO"
  gem.authors       = ["Donald Hutchison"]
  gem.email         = ["git@toastymofo.net"]
  gem.homepage      = "https://github.com/rkachowski/rubygb"
  gem.license       = "MIT"

  gem.files         = Dir["{**/}{.*,*}"].select{ |path| File.file?(path) && path !~ /^pkg/ }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = "~> 2.0"
end
