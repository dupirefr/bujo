module Configuration
  class Editor
    def initialize(command)
      @command = command
    end

    def call(relative_path)
      system("#{@command} #{relative_path}")
    end
  end
end