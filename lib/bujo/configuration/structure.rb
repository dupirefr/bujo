module Configuration
  # Ruby
  require 'fileutils'

  class Structure
    # Global
    def self.global_plugin_path(plugin_relative_path)
      File.join(global_plugins_path, plugin_relative_path)
    end

    def self.global_asset_path(relative_path)
      File.join(global_assets_path, relative_path)
    end

    def self.global_plugin_asset_path(relative_path)
      global_asset_path(File.join("bujo/plugins", relative_path))
    end

    def self.global_stylesheet_path(relative_path)
      global_asset_path(File.join("bujo/stylesheets", relative_path))
    end

    # Local
    def self.local_path(relative_path)
      File.join(local_home, relative_path)
    end

    def self.sources_path
      local_path("src")
    end

    def self.source_path(relative_path)
      File.join(sources_path, relative_path)
    end

    def self.targets_path
      local_path("target")
    end

    def self.target_path(relative_path)
      File.join(targets_path, relative_path)
    end

    def self.local_plugin_path(plugin_relative_path)
      File.join(local_plugins_path, plugin_relative_path)
    end

    def self.create_source_directory(directory_relative_path)
      FileUtils.mkdir_p(File.join(sources_path, directory_relative_path))
    end

    private

    # Global
    def self.global_home
      File.join(File.dirname(File.expand_path(__FILE__)), "../../../")
    end

    def self.global_plugins_path
      File.join(global_home, "lib/bujo/plugins")
    end

    def self.global_assets_path
      File.join(global_home, 'assets')
    end

    # Local
    def self.local_home
      Dir.pwd
    end

    def self.local_plugins_path
      local_path("plugins")
    end
  end
end