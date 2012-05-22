# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rails_simple_backup_restore/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ouvrages"]
  gem.email         = ["contact@ouvrages-web.fr"]
  gem.description   = %q{A simple backup/restore gem for Rails}
  gem.summary       = %q{Backup the database and custom paths into a single file and allow restore}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rails_simple_backup_restore"
  gem.require_paths = ["lib"]
  gem.version       = RailsSimpleBackupRestore::VERSION
  gem.add_dependency 'yaml_db'
  gem.add_dependency 'rails', '>= 3.0'
  gem.add_dependency 'rubyzip'
end
