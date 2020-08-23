module Utils
  gem 'psych'
  require 'psych'

  class Configuration
    attr_reader :style

    private def initialize(style)
      @style = style
    end

    def self.load(filename = "bujo.yaml")
      yaml = Psych.load_file(filename)
      style = Style.parse(yaml['style'])

      Configuration.new(style)
    end
  end

  class Style
    def self.parse(yaml)
      if yaml['type'] == "default"
        DefaultStyle.new
      elsif yaml['type'] == "local"
        LocalStyle.new(yaml['sheet'], yaml['directory'])
      else
        raise
      end
    end

    class DefaultStyle < Style
      def command
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