# RailsSimpleBackupRestore

A simple backup/restore gem for Rails (restore not implemented yet).

## Installation

Add this line to your application's Gemfile:

    gem 'rails_simple_backup_restore'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_simple_backup_restore

## Usage

Create a file config/backup_files with, for example :

    public/system/**/*

In your controller:

    def backup
      send_data SimpleBackup.backup.read, :filename => "Backup.zip"
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
