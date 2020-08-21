class Module
  attr_reader :name, :options

  def initialize(name, options)
    @name = name
    @options = options
  end
end