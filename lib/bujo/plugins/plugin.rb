module Plugins
  class Plugin
    attr_reader :name, :options

    protected def initialize(name, options)
      @name = name
      @options = options
    end

    def directory
      nil
    end

    def shortcuts
      []
    end

    # TODO Not sure about this
    def ==(other)
      self.class == other.class
    end
  end
end