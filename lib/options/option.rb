class Option
  attr_reader :short_name, :long_name, :description, :valued, :action, :shortcuts

  private def initialize(short_name, long_name, description, valued, action, shortcuts)
    @short_name = short_name
    @long_name = long_name
    @description = description
    @valued = valued
    @action = action
    @shortcuts = shortcuts
  end
end

class OptionBuilder
  def initialize
    @shortcuts = []
  end

  def with_name(short_name = nil, long_name)
    @short_name = short_name
    @long_name = long_name
    self
  end

  def with_description(description)
    @description = description
    self
  end

  def valued
    @valued = true
    self
  end

  def with_action(action)
    @action = action
    self
  end

  def with_shortcut(shortcut)
    @shortcuts << shortcut
    self
  end

  def build
    Option.new(@short_name, @long_name, @description, @valued, @action, @shortcuts)
  end
end