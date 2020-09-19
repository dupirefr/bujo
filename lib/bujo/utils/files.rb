module Utils
  class Files
    def self.write(path, lines)
      begin
        file = File.open(path, "w:UTF-8") { |file| file.puts(lines) }
      ensure
        file.close unless file.nil?
      end
    end
  end
end