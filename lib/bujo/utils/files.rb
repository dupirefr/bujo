module Utils
  class Files
    def self.write(source_path, destination_path)
      begin
        file = File.open(source_path, "w") { |file| file.puts(destination_path) }
      ensure
        file.close unless file.nil?
      end
    end
  end
end