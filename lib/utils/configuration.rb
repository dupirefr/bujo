module Utils
  require 'singleton'
  gem 'psych'
  require 'psych'

  class Configuration
    include Singleton
    attr_reader :style

    private def initialize
      super

      yaml = Psych.load_file("bujo.yaml")
      @style = Style.parse(yaml['style'])
    end
  end

  class Style
    def self.parse(yaml)
      if yaml['type'] == "default"
        DefaultStyle.new
      elsif yaml['type'] == "local"
        LocalStyle.new(yaml['sheet'], yaml['directory'])
      end
    end

    class DefaultStyle < Style
      def command_style_reference
        ""
      end
    end

    class LocalStyle < Style
      attr_reader :sheet, :directory

      def initialize(sheet, directory)
        @sheet = sheet
        @directory = directory
      end

      def command
        "-a stylesheet=#{@sheet} -a stylesdir=#{@directory}"
      end
    end
  end
end