module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'
  require 'bujo/utils/names'

  class ProjectPlugin < Plugin
    def initialize(dependencies = [])
      super("projects", [
          Options::Option.builder
              .with_name("p", "project")
              .with_description("Create an entry for a project in the journal")
              .valued
              .with_action(lambda { |project| create_project(project) })
              .build,
      ])

      @template_renderer = dependencies[:template_renderer]
    end

    def directory
      "projects"
    end

    def create_project(project_name)
      puts "Creating an entry for project #{project_name} in the journal"
      rendered_template = @template_renderer.render("project/template.adoc", {
          :project_name => project_name
      })
      project_source_path = Configuration::Structure.source_path("projects/#{Utils::NameUtils.computerize(project_name)}.adoc")
      begin
        file = File.open(project_source_path, "w") { |file| file.puts(rendered_template) }
      ensure
        file.close unless file.nil?
      end
    end
  end
end