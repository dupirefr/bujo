module Options
  # Ruby
  require 'minitest/autorun'

  # Own
  require_relative '../../lib/bujo/options/option'

  class OptionTest < Minitest::Test
    def test_long_only_option
      action_triggered = false
      option = default_long_only_option_builder
                   .with_action(-> { action_triggered = true })
                   .build

      assert_nil option.short_name
      assert_equal "build", option.long_name
      assert_equal "Build the project", option.description
      assert_equal false, option.valued

      option.action.call
      assert_equal true, action_triggered
    end

    def test_valued_long_only_option
      action_message = ""
      option = default_long_only_option_builder
                   .with_action(lambda { |message| action_message = message })
                   .valued
                   .build

      assert_nil option.short_name
      assert_equal "build", option.long_name
      assert_equal "Build the project", option.description
      assert_equal true, option.valued

      option.action.call("Hello")
      assert_equal "Hello", action_message
    end

    def test_int_valued_long_only_option
      action_number = 0
      option = default_long_only_option_builder
                   .with_action(lambda { |number| action_number += number })
                   .valued(Integer)
                   .build

      assert_nil option.short_name
      assert_equal "build", option.long_name
      assert_equal "Build the project", option.description
      assert_equal true, option.valued

      option.action.call(2)
      assert_equal 2, action_number
    end

    def test_short_option
      action_triggered = false
      option = default_short_option_builder
                   .with_action(-> { action_triggered = true })
                   .build

      assert_equal "b", option.short_name
      assert_equal "build", option.long_name
      assert_equal "Build the project", option.description
      assert_equal false, option.valued

      option.action.call
      assert_equal true, action_triggered
    end

    def test_valued_short_option
      action_message = ""
      option = default_short_option_builder
                   .with_action(lambda {|message| action_message = message })
                   .valued
                   .build

      assert_equal "b", option.short_name
      assert_equal "build", option.long_name
      assert_equal "Build the project", option.description
      assert_equal true, option.valued

      option.action.call("Hello")
      assert_equal "Hello", action_message
    end

    def test_int_valued_short_option
      action_number = 0
      option = default_short_option_builder
                   .with_action(lambda {|number| action_number += number })
                   .valued
                   .build

      assert_equal "b", option.short_name
      assert_equal "build", option.long_name
      assert_equal "Build the project", option.description
      assert_equal true, option.valued

      option.action.call(2)
      assert_equal 2, action_number
    end

    private

    def default_long_only_option_builder
      Option.builder
          .with_name("build")
          .with_description("Build the project")
    end

    def default_short_option_builder
      Option.builder
          .with_name("b", "build")
          .with_description("Build the project")
    end
  end
end