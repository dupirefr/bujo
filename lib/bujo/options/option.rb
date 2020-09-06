module Options
  class Option
    attr_reader :short_name, :long_name, :description, :value_type, :action

    private def initialize(short_name, long_name, description, value_type, action)
      @short_name = short_name
      @long_name = long_name
      @description = description
      @value_type = value_type
      @action = action
    end

    def self.builder
      Builder.new
    end

    def valued
      not @value_type.nil?
    end

    class Builder
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

      def valued(value_type = String)
        @value_type = value_type
        self
      end

      def with_action(action)
        @action = action
        self
      end

      def build
        Option.new(@short_name, @long_name, @description, @value_type, @action)
      end
    end
  end
end