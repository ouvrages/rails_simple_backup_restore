module SimpleBackup
  def self.init
    require 'tmpdir'
    require 'zip/zip'
    require 'yaml_db'
  end
  
  def self.current_backup_files
    files = []
    backup_files_path = Rails.root.join("config", "backup_files")
    if backup_files_path.exist?
      backup_files_path.each_line do |line|
        Dir[line.strip].each do |path|
          next if File.directory?(path)
          files << path
        end
      end
    end
    files
  end
  
  def self.db_dump_path
    "db/data.yml"
  end
  
  def self.backup
    init
    
    input_filenames = ["config/backup_version"]
    
    SerializationHelper::Base.new(YamlDb::Helper).dump db_dump_path
    
    input_filenames << db_dump_path
    
    input_filenames += current_backup_files
    
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
  
  def self.restore(file)
    init
    
    Dir.mktmpdir 'simple_restore' do |dir|
      Zip::ZipFile.open(file.path) do |zip|
        version = zip.find_entry "config/backup_version"
        raise "Invalid a backup file" unless version
        current_version = File.read("config/backup_version")
        raise "Backup version mismatch" if current_version != zip.read("config/backup_version")
        
        current_backup_files.each do |file|
          File.delete(file)
        end
        
        zip.each do |entry|
          File.open(entry.name, "wb") { |f| f.write entry.get_input_stream.read }
        end
        
        SerializationHelper::Base.new(YamlDb::Helper).load db_dump_path
      end
    end
  end
end
