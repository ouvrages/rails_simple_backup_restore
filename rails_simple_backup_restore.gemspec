# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rails_simple_backup_restore/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michael Witrant"]
  gem.email         = ["michael@ouvrages-web.fr"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rails_simple_backup_restore"
  gem.require_paths = ["lib"]
  gem.version       = RailsSimpleBackupRestore::VERSION
end