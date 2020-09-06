Gem::Specification.new do |spec|
  spec.name = "bujo"
  spec.version = "0.1.0"
  spec.date = "2020-08-23"
  spec.summary = "support CLI to maintain Bullet Journal using AsciiDoctor"
  spec.authors = "François Dupire"
  spec.email = "dupire.francois+pro@gmail.com"
  spec.files = [Dir.glob("lib/**/*"), Dir.glob("assets/**/*")].flatten
  spec.executables << "bujo"
end