# RailsSimpleBackupRestore

A simple backup/restore gem for Rails.

How it works:

`SimpleBackup.backup`:

* the database is dumped to `db/data.yml` with [yaml_db](http://rubygems.org/gems/yaml_db)
* a temporary zip file is created with:
  * `config/backup_version`
  * `db/data.yml`
  * all files listed in `config/backup_files` (each line being expanded with `Dir[line_of_backup_files]`)
* the temporary file object is returned (it may already have been removed from disk, but you can `#read` it)

`SimpleBackup.restore(file)`:

* check that the file is a ZIP and contains the same `config/backup_version`
* delete all files listed in `config/backup_files` (each line being expanded with `Dir[line_of_backup_files]`)
* extract all files included in the ZIP file
* load the database dump

## Installation

Add this line to your application's Gemfile:

    gem 'rails_simple_backup_restore'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_simple_backup_restore

## Usage

Create a file config/backup_version with, for example :

    my rails app backup v1

Create a file config/backup_files with, for example :

    public/system/**/*

In your controller:

    def backup
      send_data SimpleBackup.backup.read, :filename => "Backup.zip"
    end

    def restore
      if params[:file]
        @done = true
        begin
          SimpleBackup.restore(params[:file])
          @success = true
        rescue => e
          @error = e.message
        end
      end
    end

In the restore view (haml syntax, twitter bootstrap style):

    - if @done
      - if @success
        .alert.alert-block.alert-success
          %p
            %strong Restauration done!
      - else
        .alert.alert-block.alert-error
          %p
            %strong= "An error occured during restore"
          %p
            = @error

    = form_tag restore_path, :class => "form-horizontal", :multipart => true do
      %fieldset
        %legend Restore
        .control-group
          = label_tag :file, "Backup file", :class => "control-label"
          .controls
            = file_field_tag :file, :class => "input-file"
        .form-actions
          = submit_tag "Restore backup", :class => "btn btn-primary"


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
