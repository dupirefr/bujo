module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'

  class ProjectPlugin < Plugin
    def initialize
      super("projects", [
          Options::Option.builder
              .with_name("p", "project")
              .with_description("Create an entry for a project in the journal")
              .valued
              .with_action(lambda { |project| ProjectPlugin.create_project(project) })
              .build,
      ])
    end

    def self.create_project(project)
      puts "Creating an entry for project #{project} in the journal"
      FileUtils.copy("templates/project.adoc.tpl", "src/projects/#{project}.adoc")
    end
  end
end