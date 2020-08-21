require 'fileutils'

require_relative 'module'
require_relative '../options/option'

class ProjectsModule < Module
  def initialize
    super("projects", [
        OptionBuilder.new
            .with_name("p", "project")
            .with_description("Create an entry for a project in the journal")
            .valued
            .with_action(lambda { |project| ProjectsModule.create_project(project) })
            .build,
    ])
  end

  def self.create_project(project)
    puts "Creating an entry for project #{project} in the journal"
    FileUtils.copy("templates/project.adoc.tpl", "src/projects/#{project}.adoc")
  end
end