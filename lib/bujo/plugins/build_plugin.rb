module Plugins
  # Ruby
  require 'fileutils'
  require 'asciidoctor'

  # Own
  require 'bujo/configuration/globals'
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'

  class BuildPlugin < Plugin
    def initialize
      super("build", [
          Options::Option.builder
              .with_name("b", "build")
              .with_description("Build HTML representation of the journal")
              .with_action(-> { build_journal })
              .build
      ])
    end

    private

    def build_journal
      clean_target
      convert_files
    end

    def clean_target
      puts "Cleaning target..."
      FileUtils.rm_rf(Configuration::Structure.targets_path)
    end

    def convert_files
      puts "Converting to HTML..."
      Dir.glob(File.join(Configuration::Structure.sources_path, "**/*"))
          .select { |file| file =~ /.*\.adoc$/ }
          .each { |asciidoctor_file| convert_file(asciidoctor_file) }
    end

    def convert_file(source_path)
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