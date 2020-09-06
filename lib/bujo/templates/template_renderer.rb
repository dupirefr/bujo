module Templates
  # Own
  require 'bujo/configuration/structure'

  class TemplateRenderer
    def render(template_relative_path, placeholders_replacements)
      template_path = Configuration::Structure.global_template_path(template_relative_path)
      template = File.read(template_path)

      placeholders_replacements
          .each { |placeholder, replacement| template = template.gsub(/#{placeholder}/, replacement) }

      template
    end
  end
end