module Plugins
  class Plugin
    attr_reader :name, :options

    def initialize(name, options)
      @name = name
      @options = options
    end

    def directory
      nil
    end

    def shortcuts
      []
    end

    def ==(other)
      self.class == other.class
    end
  end
end