module Utils
  # Ruby
  require 'fileutils'
  require 'asciidoctor'

  # Own
  require 'bujo/configuration/structure'
  require 'bujo/configuration/globals'

  class Converter
    def self.for(source_path)
      source_path =~ /.*\.adoc$/ ? AsciidocFileConverter.new(source_path) : RegularFileConverter.new(source_path)
    end

    private def initialize(source_path)
      @source_path = source_path
    end

    def convert
      raise NotImplementedError
    end
  end

  class RegularFileConverter < Converter
    def convert
      source_relative_path = Pathname.new(File.expand_path(@source_path)).relative_path_from(Pathname.new(Configuration::Structure.sources_path))
      target_path = File.join(Configuration::Structure.targets_path, source_relative_path.to_s)
      puts "Converting #{@source_path} to #{target_path}..." if Configuration::Globals.verbose
      FileUtils.copy_file(@source_path, target_path)
    end
  end

  class AsciidocFileConverter < Converter
    def convert
      begin
        source_relative_path = Pathname.new(File.expand_path(@source_path)).relative_path_from(Pathname.new(Configuration::Structure.sources_path))
        source_file = File.open(@source_path)
        target_path = File.join(Configuration::Structure.targets_path, source_relative_path.to_s.gsub(/\.adoc/, ".html"))
        puts "Converting #{@source_path} to #{target_path}..." if Configuration::Globals.verbose
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