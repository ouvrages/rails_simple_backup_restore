require "rails_simple_backup_restore/version"

module RailsSimpleBackupRestore
  class Engine < Rails::Engine
    config.autoload_paths << File.expand_path("../rails_simple_backup_restore", __FILE__)
  end
end
