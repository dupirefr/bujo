require 'fileutils'

class Shortcut
  attr_reader :name, :source, :target

  def initialize(name, source, target)
    @name = name
    @source = source
    @target = target
  end

  def create
    puts("* #{@name} link: #{@source} --> #{@target}")
    FileUtils.copy("target/#{@source}", "target/#{@target}")
  end

  def to_s
    "#{@name}: #{@source} --> #{@target}"
  end
end