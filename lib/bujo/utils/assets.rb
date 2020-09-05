module Assets
  def self.directory
    File.join(File.dirname(File.expand_path(__FILE__)), '../../../assets')
  end

  def self.get(relative_path)
    File.join(directory, relative_path)
  end
end