module SimpleBackup
  def self.backup
    require 'tmpdir'
    require 'zip/zip'
    require 'yaml_db'
    
    input_filenames = []
    
    helper = YamlDb::Helper
    db_dump_path = "db/data.yml"
    SerializationHelper::Base.new(helper).dump db_dump_path
    
    input_filenames << db_dump_path
    
    backup_files_path = Rails.root.join("config", "backup_files")
    puts backup_files_path
    if backup_files_path.exist?
      backup_files_path.each_line do |line|
        Dir[line.strip].each do |path|
          next if File.directory?(path)
          input_filenames << path
        end
      end
    end
    
    zip = nil
    Dir.mktmpdir 'simple_backup' do |dir|
      zip_path = File.join(dir, "backup.zip")
      Zip::ZipFile.open(zip_path, Zip::ZipFile::CREATE) do |zipfile|
        input_filenames.each do |filename|
          zipfile.add(filename, Rails.root.join(filename))
        end
      end
      zip = File.open(zip_path, 'r')
    end
    zip
  end
end
