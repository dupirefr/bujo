module Utils
  class Converter
    def self.convert_file(source_path)
      begin
        source_relative_path = Pathname.new(source_path).relative_path_from(Pathname.new(Configuration::Structure.sources_path))
        source_file = File.open(source_path)
        target_path = File.join(Configuration::Structure.targets_path, source_relative_path.to_s.gsub(/\.adoc/, ".html"))
        puts "Converting #{source_path} to #{target_path}..." if Configuration::Globals.verbose
        Asciidoctor.convert(
            source_file,
            {
                :to_file => target_path,
                :mkdirs => true
            }
        )
      ensure
        source_file.close unless source_file.nil?
      end
    end
  end
end