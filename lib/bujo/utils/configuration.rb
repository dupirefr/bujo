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

end