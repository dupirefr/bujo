require_relative 'lib/modules/module-register'
require_relative 'lib/modules/day-module'
require_relative 'lib/modules/month-module'
require_relative 'lib/modules/projects-module'
require_relative 'lib/modules/collections-module'
require_relative 'lib/modules/build-module'

def register_default_modules(module_register)
  module_register.register(DayModule.new)
  module_register.register(MonthModule.new)
  module_register.register(ProjectsModule.new)
  module_register.register(CollectionsModule.new)
  module_register.register(BuildModule.new)
end

module_register = ModuleRegister.new
register_default_modules(module_register)
module_register.parse